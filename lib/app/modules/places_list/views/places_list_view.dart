import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:getx_best_places/app/modules/places_list/controllers/places_list_controller.dart';
import 'package:getx_best_places/app/routes/app_pages.dart';

class PlacesListView extends GetView<PlacesListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PlacesListView'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.ADD_PLACE);
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        future: controller.fetchPlaces(),
        builder: ((context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Obx(
                () => Center(
                  child: controller.places.isEmpty
                      ? Text('You list is empty- try add some places')
                      : ListView.builder(
                          itemCount: controller.places.length,
                          itemBuilder: (context, i) {
                            return Row(
                              children: [
                                Container(
                                  height: 150,
                                  width: 100,
                                  child: Image.file(controller.places[i].image),
                                ),
                                SizedBox(width: 30),
                                Text(controller.places[i].title)
                              ],
                            );
                          },
                        ),
                ),
              )),
      ),
    );
  }
}
