import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_complete_event.dart';

part 'order_complete_state.dart';

class OrderCompleteBloc extends Bloc<OrderCompleteEvent, OrderCompleteState> {
  OrderCompleteBloc() : super(OrderCompleteInitial()) {
    on<OrderCompleteEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
