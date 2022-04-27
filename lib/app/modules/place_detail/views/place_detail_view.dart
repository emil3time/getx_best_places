import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/place_detail_controller.dart';

class PlaceDetailView extends GetView<PlaceDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PlaceDetailView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PlaceDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
