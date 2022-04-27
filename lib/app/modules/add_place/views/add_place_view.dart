import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_best_places/app/modules/places_list/controllers/places_list_controller.dart';


import 'package:getx_best_places/app/widgets/image_preview.dart';

class AddPlaceView extends GetView<PlacesListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('AddPlaceView'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: controller.titleController,
                        decoration: InputDecoration(hintText: 'Title'),
                      ),
                      SizedBox(height: 20),
                      ImagePreview()
                    ],
                  ),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                controller.savePlace();
               
              },
              elevation: 0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              color: Colors.amber,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  Text('Add Place'),
                ],
              ),
            ),
          ],
        ));
  }
}
