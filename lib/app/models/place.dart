import 'dart:io';

class PlaceLocation {
  double? longitude;
  double? latitude;
  String? adress;

  PlaceLocation(this.adress, this.latitude, this.longitude);
}

class Place {
  final String id;
  final String title;
  PlaceLocation? location;
  final File image;

  Place(
      {required this.id,
      required this.image,
      this.location,
      required this.title});
}