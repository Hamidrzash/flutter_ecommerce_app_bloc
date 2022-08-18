import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:testproject/common/master/master_bloc.dart';
import 'package:testproject/common/requests.dart';
import 'package:testproject/model/product_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, MasterState> {
  List<ProductModel> categoriesItems = [];
  List<ProductModel> recommendedItems = [];

  HomeBloc() : super(HomeInitial()) {
    on<HomeGetDataEvent>((event, emit) async {
      emit(RequestLoadingState(requestType: RequestType.categories));
      emit(RequestLoadingState(requestType: RequestType.recommended));
      try {
        Request().getCategoriesItems().then((value) {
          categoriesItems = value;
          emit(RequestSuccessfulState(requestType: RequestType.categories));
        });
        await Request().getRecommendedItems().then((value) {
          recommendedItems = value;
          emit(RequestSuccessfulState(requestType: RequestType.recommended));
        });
      } catch (e) {
        emit(RequestFailedState(requestType: RequestType.home));
      }
    });
  }
}
