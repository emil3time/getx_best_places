import 'package:get/get.dart';
import 'package:getx_best_places/app/models/place.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:getx_best_places/app/services/location_services.dart';
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

  PlaceLocation userLocation = PlaceLocation(latitude: 1.0, longitude: 1.0);

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

  void showErrorDialog() {
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

  void addPlace(String title, File image) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: image,
      title: title,
    );
    _places.add(newPlace);
    DBServices.insertData('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
  }

  void savePlace() {
    if (titleController.text.isEmpty || savedImage == null) {
      showErrorDialog();
      return;
    }
    addPlace(titleController.text, savedImage!);
    Get.back();
    print(places);
  }

  Future<void> fetchPlaces() async {
    final queryData = await DBServices.queryData('user_places');
    _places.value = queryData
        .map((e) =>
            Place(id: e['id'], image: File(e['image']), title: e['title']))
        .toList();
  }

  Future<void> getCurrentUserLocatioonOnMap() async {
    final locationData = await Location().getLocation();
    // print(locationData.latitude);
    // print(locationData.longitude);

    String staticMapImageApiUrl = LocationServices.generateLocationPreviewImage(
        latitude: locationData.latitude!, longitude: locationData.longitude!);

    previewImage = staticMapImageApiUrl;
    update();
  }

  Future<void> updateUserLocationCoordinates() async {
    final locationData = await Location().getLocation();
    userLocation = PlaceLocation(
        latitude: locationData.latitude!, longitude: locationData.longitude!);
    update();
  }
}
