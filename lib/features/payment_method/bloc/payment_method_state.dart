part of 'payment_method_bloc.dart';

@immutable
abstract class PaymentMethodState {}

class PaymentMethodInitial extends PaymentMethodState {}

class ChangePaymentMethodState extends PaymentMethodState {}
