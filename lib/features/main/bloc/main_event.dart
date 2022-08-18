part of 'main_bloc.dart';

@immutable
abstract class MainEvent {}

class PageChangeEvent extends MainEvent {
  final int pageIndex;

  PageChangeEvent({required this.pageIndex});
}

class MainGetOrdersDataEvent extends MainEvent {}
