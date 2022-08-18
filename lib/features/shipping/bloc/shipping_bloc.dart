import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:testproject/common/master/master_bloc.dart';

import 'package:testproject/common/requests.dart';
import 'package:testproject/model/location_suggest_model.dart';

part 'shipping_event.dart';

part 'shipping_state.dart';

class ShippingBloc extends Bloc<ShippingEvent, MasterState> {
  late final LatLng currentLocation;
  LatLng? latLng;
  List<String> recentAddresses = [];
  List<SuggestLocationModel> autoCompleteAddresses = [];
  List<SuggestLocationModel> recentAddressesLatLng = [];
  int selectedAddress = 0;

  ShippingBloc() : super(ShippingInitial()) {
    on<SelectAddressEvent>((event, emit) {
      selectedAddress = event.address;
      emit(SelectAddressState());
    });
    on<SearchLocationEvent>((event, emit) async {
      autoCompleteAddresses = await Request().autoCompleteLocation(
          input: event.location,
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude);
      emit(SearchLocationState());
    });
    on<SetLocationEvent>((event, emit) {
      latLng = event.latLng;
      emit(SetLocationState());
    });
    on<GetLocationEvent>((event, emit) async {
      Location location = Location();
      bool serviceEnabled;
      PermissionStatus permissionGranted;
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
        final cLocation = await location.getLocation();
        currentLocation = LatLng(cLocation.latitude!, cLocation.longitude!);
        emit(RequestSuccessfulState(requestType: RequestType.location));
      } catch (e) {
        emit(RequestFailedState(requestType: RequestType.location));
      }
    });
  }
}
