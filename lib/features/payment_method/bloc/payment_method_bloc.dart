import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'payment_method_event.dart';

part 'payment_method_state.dart';

enum PaymentMethod { payPal, applePay }

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  PaymentMethod paymentMethod = PaymentMethod.payPal;

  PaymentMethodBloc() : super(PaymentMethodInitial()) {
    on<ChangePaymentMethodEvent>((event, emit) {
      paymentMethod = event.paymentMethod;
      emit(ChangePaymentMethodState());
    });
  }
}
