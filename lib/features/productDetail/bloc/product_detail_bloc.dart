import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:testproject/common/master/master_bloc.dart';

part 'product_detail_event.dart';

part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, MasterState> {

  ProductDetailBloc() : super(ProductDetailInitial()) {
    on<ProductDetailEvent>((event, emit) {

    });
  }
}
