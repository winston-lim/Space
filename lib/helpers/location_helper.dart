import 'dart:convert';
//for http requests
import 'package:http/http.dart' as http;

//TODO: Check if API key should be private
const GOOGLE_API_KEY = '';

class LocationHelper {
  // generates a string that is returned from google's static map api which is a image of our location on Maps
  static String generateLocationPreview({
    double latitude,
    double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  //TODO: return type should be string and not dynamic, check again
  static Future<dynamic> getNamedAddress(
      double latitude, double longitude) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_API_KEY';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
