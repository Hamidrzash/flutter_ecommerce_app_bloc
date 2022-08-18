import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:testproject/common/master/master_bloc.dart';
import 'package:testproject/common/requests.dart';
import 'package:testproject/common/utils.dart';
import 'package:testproject/model/order_model.dart';

part 'main_event.dart';

part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MasterState> {
  int pageIndex = 0;

  int get itemCount {
    int itemCount = 0;
    for (var element in carts) {
      itemCount += element.count;
    }
    return itemCount;
  }

  MainBloc() : super(MainInitial()) {
    Utils().orderValueNotifier.addListener(() {
      final newOrder = Utils().orderValueNotifier.value;

      if (newOrder != null) {
        bool isSame = carts.any((element) => element.id == newOrder.id);
        if (!isSame) {
          carts.add(newOrder);
        }
        for (int i = 0; i < carts.length; i++) {
          if (carts[i].count == 0) {
            carts.removeAt(i);
          }
        }
      } else if (newOrder == null) {
        carts.clear();
      }
    });

    on<MainGetOrdersDataEvent>((event, emit) async {
      emit(RequestLoadingState(requestType: RequestType.main));
      try {
        await Request().getOrderData().then((value) {
          carts = value;
          emit(RequestSuccessfulState(requestType: RequestType.main));
        });
      } catch (e) {
        emit(RequestFailedState(requestType: RequestType.main));
      }
    });

    on<PageChangeEvent>((event, emit) {
      pageIndex = event.pageIndex;
      emit(PageChangeState());
    });
  }

  List<OrderModel> carts = [];
}
