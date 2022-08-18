import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:testproject/common/utils.dart';

part 'recovery_password_event.dart';

part 'recovery_password_state.dart';

class RecoveryPasswordBloc
    extends Bloc<RecoveryPasswordEvent, RecoveryPasswordState> {
  bool isValid = false;

  RecoveryPasswordBloc() : super(RecoveryPasswordInitial()) {
    on<InputValidateEvent>((event, emit) {
      if (Utils().validateEmail(event.email)) {
        isValid = true;
        emit(InputValidateState());
      } else {
        isValid = false;
        emit(InputValidateState());
      }
    });
  }
}
