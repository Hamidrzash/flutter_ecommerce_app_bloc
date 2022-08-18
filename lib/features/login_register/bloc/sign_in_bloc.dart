import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:testproject/common/master/master_bloc.dart';
import 'package:testproject/common/pref.dart';
import 'package:testproject/common/requests.dart';
import 'package:testproject/model/location_model.dart';
import 'package:testproject/model/user_model.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class LoginRegisterBloc extends Bloc<LoginRegisterEvent, MasterState> {
  bool isObscure = true;
  bool isConditionAccepted = false;

  LoginRegisterBloc() : super(LoginRegisterInitial()) {
    on<GetLocationEvent>((event, emit) async {
      Location location = Location();
      bool serviceEnabled;
      PermissionStatus permissionGranted;
      LocationData locationData;
      emit(RequestLoadingState(requestType: RequestType.location));
      try {
        serviceEnabled = await location.serviceEnabled();
        if (!serviceEnabled) {
          serviceEnabled = await location.requestService();
          if (!serviceEnabled) {
            emit(RequestFailedState(requestType: RequestType.location));
            return;
          }
        }

        permissionGranted = await location.hasPermission();
        if (permissionGranted == PermissionStatus.denied) {
          permissionGranted = await location.requestPermission();
          if (permissionGranted != PermissionStatus.granted) {
            emit(RequestFailedState(requestType: RequestType.location));
            return;
          }
        }
        locationData = await location.getLocation();
        LocationModel locationModel = await Request()
            .getLocation(locationData.latitude!, locationData.longitude!);
        Pref.deviceLocation = '${locationModel.country}, ${locationModel.city}';
        emit(RequestSuccessfulState(requestType: RequestType.location));
      } catch (e) {
        emit(RequestFailedState(requestType: RequestType.location));
      }
    });

    on<RegisterEvent>((event, emit) {
      try {
        Pref().registerUser(UserModel(
          userName: event.userName,
          email: event.email,
          token: event.pass,
        ));
        Pref().isLoggedIn = true;
        emit(RequestSuccessfulState(requestType: RequestType.register));
      } catch (e) {
        emit(RequestFailedState(
            error: 'Login Failed', requestType: RequestType.register));
      }
    });

    on<LogInEvent>((event, emit) async {
      if (await Pref().logInUser(event.email, event.pass)) {
        Pref().isLoggedIn = true;
        emit(RequestSuccessfulState(requestType: RequestType.login));
      } else {
        emit(RequestFailedState(
            error: 'Login Failed', requestType: RequestType.login));
      }
    });

    on<VisibleObscureTextEvent>((event, emit) {
      isObscure = !isObscure;
      emit(VisibleObscureTextState());
    });
    on<AcceptConditionEvent>((event, emit) {
      isConditionAccepted = !isConditionAccepted;
      emit(AcceptConditionState());
    });
    on<FacebookEvent>((event, emit) {});
  }
}
