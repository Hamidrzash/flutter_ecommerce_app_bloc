part of 'master_bloc.dart';

@immutable
abstract class MasterState {
  final RequestType requestType;

  const MasterState({this.requestType = RequestType.initial});
}

class MasterInitial extends MasterState {}

enum RequestType {
  initial,
  main,
  login,
  register,
  location,
  categories,
  recommended,
  home,
  order,
  changeOrder,
  searchItem,
  popularSearches,
  shipping
}

class RequestSuccessfulState extends MasterState {
  final RequestType requestType;

  RequestSuccessfulState({required this.requestType});
}

class RequestFailedState extends MasterState {
  final RequestType requestType;
  final String error;

  RequestFailedState(
      {required this.requestType, this.error = 'Request Failed'});
}

class RequestLoadingState extends MasterState {
  final RequestType requestType;

  RequestLoadingState({required this.requestType});
}
