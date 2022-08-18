part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchItemEvent extends SearchEvent {
  final String text;

  SearchItemEvent({required this.text});
}

class GetPopularSearchesEvent extends SearchEvent {}

class EmptySearchEvent extends SearchEvent {}

class RecentSearchChangeEvent extends SearchEvent {
  final int index;

  RecentSearchChangeEvent({required this.index});
}

class RecentSearchAddEvent extends SearchEvent {
  final String text;

  RecentSearchAddEvent({required this.text});
}
