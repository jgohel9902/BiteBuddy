import 'package:bitebuddy/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/restaurant.dart';
import '../services/api_service.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailScreen({super.key, required this.restaurant});

  void _launchMap() async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${restaurant.lat},${restaurant.lng}',
    );
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch map';
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        restaurant.photoReference.isNotEmpty
            ? ApiService.buildPhotoUrl(restaurant.photoReference, maxWidth: 800)
            : 'https://via.placeholder.com/600';

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () async {
              await DBService.addBookmark(restaurant);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Bookmarked (mock)!')));
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Image.network(
            imageUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                RatingBarIndicator(
                  rating: restaurant.rating,
                  itemCount: 5,
                  itemSize: 20,
                  itemBuilder:
                      (context, _) => Icon(Icons.star, color: Colors.amber),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.redAccent),
                    SizedBox(width: 5),
                    Expanded(child: Text(restaurant.address)),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _launchMap,
                  icon: Icon(Icons.map),
                  label: Text('Open in Google Maps'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    minimumSize: Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
