import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:testproject/common/master/master_bloc.dart';
import 'package:testproject/common/requests.dart';
import 'package:testproject/model/product_model.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, MasterState> {
  List<String> recentSearch = [];
  List<ProductModel> foundedItems = [];
  List<ProductModel> popularSearch = [];

  SearchBloc() : super(SearchInitial()) {
    on<SearchItemEvent>((event, emit) async {
      emit(RequestLoadingState(requestType: RequestType.searchItem));
      try {
        await Request().searchItem(event.text).then((value) {
          foundedItems = value;
          emit(RequestSuccessfulState(requestType: RequestType.searchItem));
        });
      } catch (e) {
        emit(RequestFailedState(requestType: RequestType.searchItem));
      }
    });
    on<EmptySearchEvent>((event, emit) => emit(EmptySearchState()));
    on<RecentSearchAddEvent>((event, emit) {
      recentSearch.add(event.text);
      emit(RecentSearchAddState());
    });

    on<RecentSearchChangeEvent>((event, emit) {
      recentSearch.removeAt(event.index);

      emit(RecentSearchChangeState());
    });

    on<GetPopularSearchesEvent>((event, emit) async {
      emit(RequestLoadingState(requestType: RequestType.popularSearches));
      try {
        await Request().getPopularItems().then((value) {
          popularSearch = value;
          emit(
              RequestSuccessfulState(requestType: RequestType.popularSearches));
        });
      } catch (e) {
        emit(RequestFailedState(requestType: RequestType.popularSearches));
      }
    });
  }
}
