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
        actions: [
          GetBuilder<PlacesListController>(builder: (value) {
            return value.isSelecting
                ? IconButton(
                    onPressed: () {
                      controller.getSelectedUserLocationOnMap();
                    },
                    icon: Icon(Icons.check))
                : SizedBox();
          })
        ],
      ),
      body: GetBuilder<PlacesListController>(
        builder: (value) {
          return GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(controller.userLocation!.latitude,
                    controller.userLocation!.longitude),
                zoom: 16),
            onTap: value.selectLocation,
            markers: value.selectedPosition == null
                ? {}
                : {
                    Marker(
                        markerId: MarkerId('m1'),
                        position: value.selectedPosition!)
                  },
          );
        },
      ),
    );
  }
}
