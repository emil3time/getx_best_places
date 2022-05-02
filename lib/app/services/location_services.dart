import '../data/api_key.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationServices {
  String apiKey = GOOGLE_API_KEY;

  static String generateLocationPreviewImage(
      {required double longitude, required double latitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<http.Response> getAddress(
      {required double lat, required double long}) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$GOOGLE_API_KEY_GEOCODING');

    http.Response response = await http.get(url);
    // final decodedResponse = jsonDecode(response.body);
    // // print('.>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
    // print(decodedResponse['results'][0]['formatted_address']);
    return response;
  }
}
