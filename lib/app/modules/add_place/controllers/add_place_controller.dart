// import 'dart:io';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as p;
// import 'package:path_provider/path_provider.dart' as syspaths;

// import '../../../models/place.dart';

class AddPlaceController extends GetxController {
//   final RxList<Place> _places = <Place>[].obs;

//   List<Place> get places {
//     return [..._places];
//   }

//   TextEditingController titleController = TextEditingController();

//   File? takeImage;
//   File? savedImage;

//   Future<void> takePicture() async {
//     final picker = ImagePicker();
//     final imageFile =
//         await picker.pickImage(source: ImageSource.camera, maxWidth: 600);
//     takeImage = File((imageFile as XFile).path);
//     update();
//     final appDir = await syspaths.getApplicationDocumentsDirectory();
//     final fileName = p.basename(imageFile.path);
//     savedImage = await takeImage!.copy('${appDir.path}/$fileName');
//   }

//   void savePlace() {
//     if (titleController.text.isEmpty || savedImage == null) {
//       return;
//     }
//     addPlace(titleController.text, savedImage!);
//   }

//   void addPlace(String title, File image) {
//     final newPlace = Place(
//       id: DateTime.now().toString(),
//       image: image,
//       title: title,
//     );
//     places.add(newPlace);
//   }
}
