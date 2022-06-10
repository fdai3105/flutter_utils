part of 'explore_bloc.dart';

abstract class ExploreEvent extends Equatable {
  const ExploreEvent();
}

class LoadCoinTrendingEvent extends ExploreEvent {
  @override
  List<Object?> get props => [];
}

class LoadNewsEvent extends ExploreEvent {
  @override
  List<Object?> get props => [];
}
