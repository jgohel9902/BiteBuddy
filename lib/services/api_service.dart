import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/restaurant.dart';

class ApiService {
  static const String _apiKey = 'AIzaSyBN7SnDoxrlzC2K6c-A2zt6vtfR8VM9BWs';
  static const double _lat = 43.6532;
  static const double _lng = -79.3832;

  static Future<List<Restaurant>> fetchRestaurants() async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
      '?location=$_lat,$_lng'
      '&radius=2000'
      '&type=restaurant'
      '&key=$_apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List results = json.decode(response.body)['results'];
      return results.map((json) => Restaurant.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  static String buildPhotoUrl(String ref, {int maxWidth = 400}) {
    return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=$maxWidth&photo_reference=$ref&key=$_apiKey';
  }
}
