import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../services/api_service.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RestaurantTile extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantTile({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageUrl = restaurant.photoReference.isNotEmpty
        ? ApiService.buildPhotoUrl(restaurant.photoReference)
        : 'https://via.placeholder.com/150';

    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(imageUrl, height: 60, width: 60, fit: BoxFit.cover),
        ),
        title: Text(
          restaurant.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(restaurant.address, maxLines: 1, overflow: TextOverflow.ellipsis),
            RatingBarIndicator(
              rating: restaurant.rating,
              itemSize: 16,
              itemCount: 5,
              itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, '/details', arguments: restaurant);
        },
      ),
    );
  }
}
