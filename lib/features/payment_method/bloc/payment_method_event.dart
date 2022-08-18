part of 'payment_method_bloc.dart';

@immutable
abstract class PaymentMethodEvent {}

class ChangePaymentMethodEvent extends PaymentMethodEvent {
  final PaymentMethod paymentMethod;

  ChangePaymentMethodEvent({required this.paymentMethod});
}
