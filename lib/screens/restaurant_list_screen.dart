import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../services/api_service.dart';
import '../widgets/restaurant_tile.dart';

class RestaurantListScreen extends StatefulWidget {
  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  late Future<List<Restaurant>> _restaurants;

  @override
  void initState() {
    super.initState();
    _restaurants = ApiService.fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>>(
      future: _restaurants,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.red));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No restaurants found.'));
        } else {
          return ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return RestaurantTile(restaurant: snapshot.data![index]);
            },
          );
        }
      },
    );
  }
}
