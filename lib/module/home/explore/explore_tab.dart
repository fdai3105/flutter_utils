import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../data/model/_model.dart';
import '../../../theme/app_color.dart';
import '../../../widget/_widget.dart';
import 'explore_bloc.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({Key? key}) : super(key: key);

  List<Widget> buildTrendingItem(List<CoinTrendingItem> items) {
    final widgets = <Widget>[];
    for (final i in items) {
      widgets.add(GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.dark2,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              WidgetImage(url: i.item.small, height: 16, width: 16),
              const SizedBox(width: 10),
              Text(i.item.symbol),
            ],
          ),
        ),
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          WidgetField(onChanged: (v) {}, label: 'Search'),
          const SizedBox(height: 20),
          const Text(
            'Trending',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          BlocBuilder<ExploreBloc, ExploreState>(
            bloc: ExploreBloc()..add(LoadCoinTrendingEvent()),
            builder: (context, state) {
              if (state.trendLoading) {
                return const Center(child: CupertinoActivityIndicator());
              }
              if (state.trending == null) {
                return const Center(child: Text('Server error'));
              }
              return Wrap(
                direction: Axis.horizontal,
                spacing: 6,
                runSpacing: 6,
                children: [...buildTrendingItem(state.trending!.coins)],
              );
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'News',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          BlocBuilder<ExploreBloc, ExploreState>(
            bloc: ExploreBloc()..add(LoadNewsEvent()),
            builder: (context, state) {
              if (state.newsLoading) {
                return const Center(child: CupertinoActivityIndicator());
              }
              if (state.news == null) {
                return const Center(child: Text('Server error'));
              }
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.news!.data.length,
                itemBuilder: (context, i) {
                  final item = state.news!.data[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        WidgetImage(
                          url: item.cover,
                          width: 60,
                          height: 60,
                          border: 14,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.meta.title),
                              const SizedBox(height: 4),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: AppColors.light6,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: item.meta.sourceName
                                          .replaceAll('.', ''),
                                    ),
                                    const TextSpan(text: ' • '),
                                    TextSpan(
                                      text: timeago.format(
                                        item.meta.releasedAt,
                                        locale: 'en_short',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
