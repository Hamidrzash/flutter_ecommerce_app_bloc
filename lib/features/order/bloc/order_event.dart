part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class IncreaseCountEvent extends OrderEvent {}

class DecreaseCountEvent extends OrderEvent {}

class GetOrdersDataEvent extends OrderEvent {}

class TotalPriceChangeEvent extends OrderEvent {}

class ChangeOrderDataEvent extends OrderEvent {}
