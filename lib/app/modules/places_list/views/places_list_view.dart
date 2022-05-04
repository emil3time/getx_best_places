import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_best_places/app/modules/place_detail/views/place_detail_view.dart';

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
                            return InkWell(
                              // better way is send whole single object / for refresh use filtering method
                              onTap: () => Get.to(() => PlaceDetailView(),
                                  arguments: controller.places[i].id),
                              child: Row(
                                children: [
                                  Container(
                                    height: 150,
                                    width: 100,
                                    child:
                                        Image.file(controller.places[i].image),
                                  ),
                                  SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.places[i].title),
                                      SizedBox(height: 20),
                                      SizedBox(
                                        height: 50,
                                        width: 250,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(controller
                                              .places[i].location!.adress!),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                ),
              )),
      ),
    );
  }
}
