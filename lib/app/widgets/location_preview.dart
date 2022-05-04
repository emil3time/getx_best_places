import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_best_places/app/modules/add_place/views/map_screen_view.dart';
import 'package:getx_best_places/app/modules/places_list/controllers/places_list_controller.dart';

class LocationPreview extends GetView<PlacesListController> {
  const LocationPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PlacesListController>(
          builder: (value) => Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 3, color: Colors.grey),
            ),
            child: value.previewImage == null
                ? Center(child: Text('Choose Location'))
                : Image.network(
                    value.previewImage!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: () {
                  controller.getCurrentUserLocationOnMap();
                },
                icon: Icon(Icons.location_on),
                label: Text('Current Location')),
            TextButton.icon(
                onPressed: () async {

                  await controller
                      .selectOnMapStartingPoint()
                      .then((_) => Get.off(MapScreen(), fullscreenDialog: true));
                  if (controller.selectedPosition == null) {
                    return;
                  }

                },
                icon: Icon(Icons.map),
                label: Text('Select on Map')),
          ],
        )
      ],
    );
  }
}
