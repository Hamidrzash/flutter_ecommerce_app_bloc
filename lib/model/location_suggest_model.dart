class SuggestLocationModel {
  String address;
  double latitude;
  double longitude;

  factory SuggestLocationModel.fromMap(Map<String, dynamic> map) {
    return SuggestLocationModel(
      address: map['address'],
      latitude: map['location']['y'],
      longitude: map['location']['x'],
    );
  }

  factory SuggestLocationModel.fromMapStorage(Map<String, dynamic> map) {
    return SuggestLocationModel(
      address: map['address'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  SuggestLocationModel(
      {required this.address, required this.latitude, required this.longitude});
}
