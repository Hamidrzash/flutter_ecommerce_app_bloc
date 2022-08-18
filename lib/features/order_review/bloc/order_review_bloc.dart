import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_review_event.dart';

part 'order_review_state.dart';

class OrderReviewBloc extends Bloc<OrderReviewEvent, OrderReviewState> {
  OrderReviewBloc() : super(OrderReviewInitial()) {
    on<OrderReviewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
