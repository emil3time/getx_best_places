import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/modules/places_list/bindings/places_list_binding.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
    initialBinding: PlacesListBinding(),
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
