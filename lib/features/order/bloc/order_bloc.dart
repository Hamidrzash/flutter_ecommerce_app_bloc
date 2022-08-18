import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:testproject/common/master/master_bloc.dart';
import 'package:testproject/common/requests.dart';
import 'package:testproject/model/order_model.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, MasterState> {
  List<OrderModel> orderList = [];

  OrderBloc() : super(OrderInitial()) {
    on<IncreaseCountEvent>((event, emit) {
      emit(IncreaseCountState());
    });
    on<ChangeOrderDataEvent>((event, emit) async {
      emit(RequestLoadingState(requestType: RequestType.changeOrder));
      try {
        await Request().changeOrderData(orderList);
      } catch (e) {
        emit(RequestFailedState(requestType: RequestType.changeOrder));
      }
      emit(RequestSuccessfulState(requestType: RequestType.changeOrder));
    });
    on<TotalPriceChangeEvent>((event, emit) {
      emit(PriceChangeState());
    });

    on<GetOrdersDataEvent>((event, emit) async {
      emit(RequestLoadingState(requestType: RequestType.order));
      try {
        await Request().getOrderData().then((value) {
          orderList = value;
          emit(RequestSuccessfulState(requestType: RequestType.order));
        });
      } catch (e) {
        emit(RequestFailedState(requestType: RequestType.order));
      }
    });
    on<DecreaseCountEvent>((event, emit) {
      emit(DecreaseCountState());
    });
  }
}
