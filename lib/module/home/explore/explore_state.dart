part of 'explore_bloc.dart';

class ExploreState extends Equatable {
  final bool trendLoading;
  final CoinTrending? trending;
  final bool newsLoading;
  final New? news;

  const ExploreState({
    this.trendLoading = true,
    this.trending,
    this.newsLoading = true,
    this.news,
  });

  ExploreState copyWith({
    bool? trendLoading,
    CoinTrending? trending,
    bool? newsLoading,
    New? news,
  }) {
    return ExploreState(
      trendLoading: trendLoading ?? this.trendLoading,
      trending: trending ?? this.trending,
      newsLoading: newsLoading ?? this.newsLoading,
      news: news ?? this.news,
    );
  }

  @override
  List<Object?> get props => [trendLoading, trending, newsLoading, news];
}
