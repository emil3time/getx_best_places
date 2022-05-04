import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_best_places/app/modules/add_place/views/map_screen_view.dart';
import 'package:getx_best_places/app/modules/places_list/controllers/places_list_controller.dart';

class PlaceDetailView extends GetView<PlacesListController> {
  final id = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final place = controller.filterPlaceById(id);

    return Scaffold(
        appBar: AppBar(
          title: Text('PlaceDetailView'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              height: 450,
              width: double.infinity,
              child: Image.file(
                place.image,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    place.location!.adress!,
                    style: TextStyle(fontSize: 18),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  TextButton.icon(
                    onPressed: () {
                      controller.showSavedUserLocation(
                          savedLat: place.location!.latitude,
                          savedLong: place.location!.longitude);
                      Get.to(() => MapScreen());
                    },
                    icon: Icon(
                      Icons.map_outlined,
                      size: 40,
                    ),
                    label: Text(
                      'View on Map',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
