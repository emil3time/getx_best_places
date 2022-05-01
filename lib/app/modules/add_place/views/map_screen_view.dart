import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_best_places/app/modules/places_list/controllers/places_list_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends GetView<PlacesListController> {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(controller.userLocation.latitude,
                controller.userLocation.longitude),
            zoom: 16),
      ),
    );
  }
}
