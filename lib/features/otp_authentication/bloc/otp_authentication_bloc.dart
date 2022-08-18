import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'otp_authentication_event.dart';

part 'otp_authentication_state.dart';

class OtpAuthenticationBloc
    extends Bloc<OtpAuthenticationEvent, OtpAuthenticationState> {
  OtpAuthenticationBloc() : super(OtpAuthenticationInitial()) {
    on<OtpAuthenticationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
