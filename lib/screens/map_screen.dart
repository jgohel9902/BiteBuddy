import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/api_service.dart';
import '../models/restaurant.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  Set<Marker> _markers = {};
  LatLng _center = LatLng(43.6532, -79.3832); // Toronto

  @override
  void initState() {
    super.initState();
    _loadRestaurants();
  }

  void _loadRestaurants() async {
    try {
      final restaurants = await ApiService.fetchRestaurants();
      Set<Marker> markers = restaurants.map((r) {
        return Marker(
          markerId: MarkerId(r.id),
          position: LatLng(r.lat, r.lng),
          infoWindow: InfoWindow(title: r.name, snippet: r.address),
        );
      }).toSet();

      setState(() {
        _markers = markers;
      });
    } catch (e) {
      print('Error loading restaurants for map: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (controller) => _mapController = controller,
      initialCameraPosition: CameraPosition(target: _center, zoom: 13),
      markers: _markers,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
    );
  }
}
