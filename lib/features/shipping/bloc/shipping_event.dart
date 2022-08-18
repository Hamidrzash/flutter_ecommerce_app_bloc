part of 'shipping_bloc.dart';

@immutable
abstract class ShippingEvent {}

class GetLocationEvent extends ShippingEvent {}

class SetLocationEvent extends ShippingEvent {
  LatLng latLng;

  SetLocationEvent({required this.latLng});
}

class SearchLocationEvent extends ShippingEvent {
  String location;

  SearchLocationEvent({required this.location});
}

class SelectAddressEvent extends ShippingEvent {
  int address;

  SelectAddressEvent({required this.address});
}
