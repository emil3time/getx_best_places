import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx_best_places/app/models/place.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:getx_best_places/app/modules/add_place/views/add_place_view.dart';
import 'package:getx_best_places/app/services/location_services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:location/location.dart';

import '../../../models/place.dart';
import '../../../services/db_services.dart';

class PlacesListController extends GetxController {
  final RxList<Place> _places = <Place>[].obs;

  List<Place> get places {
    return [..._places];
  }

  TextEditingController titleController = TextEditingController();

  File? takeImage;
  File? savedImage;

  String? previewImage;

  PlaceLocation? userLocation;
  LatLng? selectedPosition;
  LatLng? savedPosition;
  bool isSelecting = false;

  Future<void> takePicture() async {
    final picker = ImagePicker();
    final imageFile =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (imageFile == null) {
      return;
    }
    takeImage = File((imageFile).path);
    update();
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = p.basename(imageFile.path);
    savedImage = await takeImage!.copy('${appDir.path}/$fileName');
  }

  void _showErrorDialog() {
    Get.defaultDialog(
        barrierDismissible: false,
        backgroundColor: Colors.white38,
        title: 'Error',
        middleText: 'Add photo or title to Your places',
        actions: [
          TextButton.icon(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.close),
            label: Text('OK'),
          ),
        ]);
  }

  Future<void> _addPlace(
      {required String title,
      required File image,
      required PlaceLocation userLocation}) async {
    var response = await LocationServices.getAddress(
        lat: userLocation.latitude, long: userLocation.longitude);

    Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    final address = decodedResponse['results'][0]['formatted_address'];
    userLocation = PlaceLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
        adress: address);

    final newPlace = Place(
        id: DateTime.now().toString(),
        image: image,
        title: title,
        location: userLocation);
    _places.add(newPlace);
    DBServices.insertData('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'address': userLocation.adress!,
      'lat': userLocation.latitude,
      'long': userLocation.longitude
    });
  }

  Future<void> savePlace() async {
    if (titleController.text.isEmpty ||
        savedImage == null ||
        userLocation == null) {
      _showErrorDialog();
      return;
    }
    await _addPlace(
        title: titleController.text,
        image: savedImage!,
        userLocation: userLocation!);
    Get.back();
    print(places);
  }

  Future<void> fetchPlaces() async {
    final queryData = await DBServices.queryData('user_places');
    _places.value = queryData
        .map(
          (e) => Place(
            id: e['id'],
            image: File(e['image']),
            title: e['title'],
            location: PlaceLocation(
              latitude: e['lat'],
              longitude: e['long'],
              adress: e['address'],
            ),
          ),
        )
        .toList();
  }

  void _setUserLocation({required double lat, required double long}) {
    userLocation = PlaceLocation(latitude: lat, longitude: long);
  }

  void _showPreview({required double lat, required double long}) {
    final staticMapImageApiUrl = LocationServices.generateLocationPreviewImage(
        latitude: lat, longitude: long);

    previewImage = staticMapImageApiUrl;
  }

  void showSavedUserLocation(
      {required double savedLat, required double savedLong}) {
    _setUserLocation(lat: savedLat, long: savedLong);

    savedPosition = LatLng(savedLat, savedLong);

    selectedPosition = null;

    isSelecting = false;
    update();
  }

  Future<void> getCurrentUserLocationOnMap() async {
    final locationData = await Location().getLocation();

    _showPreview(lat: locationData.latitude!, long: locationData.longitude!);

    _setUserLocation(
        lat: locationData.latitude!, long: locationData.longitude!);

    update();
  }

  Future<void> selectOnMapStartingPoint() async {
    savedPosition = null;

    if (selectedPosition != null) {
      _setUserLocation(
          lat: selectedPosition!.latitude, long: selectedPosition!.longitude);
      return;
    }
    final locationData = await Location().getLocation();

    _setUserLocation(
        lat: locationData.latitude!, long: locationData.longitude!);
  }

  void selectLocation(LatLng position) {
    selectedPosition = position;

    _setUserLocation(
        lat: selectedPosition!.latitude, long: selectedPosition!.longitude);

    isSelecting = true;

    update();
  }

  void getSelectedUserLocationOnMap() {
    _showPreview(
        lat: selectedPosition!.latitude, long: selectedPosition!.longitude);

    update();

    Get.off(AddPlaceView());
  }

  Place filterPlaceById(String id) {
    final filteredPLace = places.firstWhere((element) => element.id == id);

    return filteredPLace;
  }
}
