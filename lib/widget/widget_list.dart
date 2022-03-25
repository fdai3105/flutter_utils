part of 'widget.dart';

class WidgetList<T> extends StatefulWidget {
  final Future<List<T>?> Function() load;
  final Future<List<T>?> Function(int page) loadMore;
  final Widget Function<T>(T item) buildItem;

  const WidgetList({
    Key? key,
    required this.load,
    required this.loadMore,
    required this.buildItem,
  }) : super(key: key);

  @override
  _WidgetListState createState() => _WidgetListState();
}

class _WidgetListState<T> extends State<WidgetList> {
  List? items;
  bool loading = true;
  int page = 1;
  bool loadMoreLoading = false;
  bool loadMoreEnd = false;

  late final ScrollController sc;

  @override
  void initState() {
    super.initState();
    sc = ScrollController();
    sc.addListener(() {
      if (!sc.hasClients || loadMoreLoading) return;
      if (sc.position.extentAfter < 200) loadMore();
    });
    load();
  }

  Future load() async {
    setState(() => loading = true);
    final resp = await widget.load();
    items = resp;
    setState(() => loading = false);
  }

  Future loadMore() async {
    page++;
    setState(() => loadMoreLoading = true);
    final resp = await widget.loadMore(page);
    if (resp == null || resp.isEmpty) {
      setState(() => loadMoreEnd = true);
      page--;
    }
    setState(() => items = [...?items, ...?resp]);
    setState(() => loadMoreLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Center(child: CircularProgressIndicator());
    if (loading && (items?.isEmpty ?? true)) {
      return const Text('Nothing to show');
    }
    if (!loading && items == null) {
      return const Center(child: Text('Server Err'));
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      controller: sc,
      itemCount: items!.length + 1,
      itemBuilder: (context, i) {
        if (i == items!.length) {
          if (loadMoreLoading) {
            return const Padding(
              padding: EdgeInsets.all(10),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (loadMoreEnd) {
            return const Padding(
              padding: EdgeInsets.all(10),
              child: Center(child: Text('end of page')),
            );
          }
          return const SizedBox();
        }
        return widget.buildItem(items![i]);
      },
    );
  }
}
