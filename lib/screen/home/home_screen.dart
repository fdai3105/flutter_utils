part of 'home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TabNavigationScreen(),
            ),
          ),
          icon: const Icon(Icons.ac_unit_rounded),
        ),
      ]),
      body: SafeArea(
        child: WidgetList<PassengerDatum>(
          load: () => PassengerProvider().loadPassenger(1),
          loadMore: (page) => PassengerProvider().loadPassenger(page),
          buildItem: <T>(item) {
            final i = item as PassengerDatum;
            return ListTile(
              leading: Image.network(i.airline.first.logo ?? '', width: 80),
              title: Text(i.name),
            );
          },
        ),
      ),
    );
  }
}
