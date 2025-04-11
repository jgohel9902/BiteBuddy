class Restaurant {
  final String id;
  final String name;
  final String address;
  final String photoReference;
  final double rating;
  final double lat;
  final double lng;

  Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.photoReference,
    required this.rating,
    required this.lat,
    required this.lng,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    final location = json['geometry']['location'];
    final photos = json['photos'] ?? [];

    return Restaurant(
      id: json['place_id'],
      name: json['name'],
      address: json['vicinity'] ?? '',
      photoReference: photos.isNotEmpty ? photos[0]['photo_reference'] : '',
      rating: json['rating']?.toDouble() ?? 0.0,
      lat: location['lat'],
      lng: location['lng'],
    );
  }
}
