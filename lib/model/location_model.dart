class LocationModel {
  String city;
  String country;

  LocationModel({
    required this.city,
    required this.country,
  });

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      country: map['country'],
      city: map['name'],
    );
  }
}
