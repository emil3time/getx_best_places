import 'package:get/get.dart';

import '../controllers/places_list_controller.dart';

class PlacesListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlacesListController>(
      () => PlacesListController(),
    );
  }
}
