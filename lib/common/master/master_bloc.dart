import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'master_event.dart';

part 'master_state.dart';

class MasterBloc extends Bloc<MasterEvent, MasterState> {
  MasterBloc() : super(MasterInitial()) {
    on<MasterEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
