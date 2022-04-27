import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_best_places/app/modules/add_place/controllers/add_place_controller.dart';
import 'package:getx_best_places/app/modules/places_list/controllers/places_list_controller.dart';

class ImagePreview extends GetView<PlacesListController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GetBuilder<PlacesListController>(
            builder: (value) => Container(
                  alignment: Alignment.center,
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45, width: 3)),
                  child: value.takeImage != null
                      ? Image.file(
                          value.takeImage!,
                          fit: BoxFit.fill,
                        )
                      : Text('add a photo '),
                )),
        Expanded(
          child: TextButton.icon(
              onPressed: () {
                controller.takePicture();
              },
              icon: Icon(Icons.add_a_photo),
              label: Text('add photo')),
        )
      ],
    );
  }
}
