import '../data/api_key.dart';

class LocationServices {
   String apiKey = GOOGLE_API_KEY;

  static String generateLocationPreviewImage(
      {required double longitude, required double latitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}
