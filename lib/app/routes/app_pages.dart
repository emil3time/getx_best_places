import 'package:get/get.dart';

import 'package:getx_best_places/app/modules/add_place/bindings/add_place_binding.dart';
import 'package:getx_best_places/app/modules/add_place/views/add_place_view.dart';
import 'package:getx_best_places/app/modules/home/bindings/home_binding.dart';
import 'package:getx_best_places/app/modules/home/views/home_view.dart';
import 'package:getx_best_places/app/modules/place_detail/bindings/place_detail_binding.dart';
import 'package:getx_best_places/app/modules/place_detail/views/place_detail_view.dart';
import 'package:getx_best_places/app/modules/places_list/bindings/places_list_binding.dart';
import 'package:getx_best_places/app/modules/places_list/views/places_list_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.PLACES_LIST;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PLACES_LIST,
      page: () => PlacesListView(),
      binding: PlacesListBinding(),
    ),
    GetPage(
      name: _Paths.PLACE_DETAIL,
      page: () => PlaceDetailView(),
      binding: PlaceDetailBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PLACE,
      page: () => AddPlaceView(),
      binding: AddPlaceBinding(),
    ),
  ];
}
