import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../services/db_service.dart';

class AddRestaurantScreen extends StatefulWidget {
  @override
  _AddRestaurantScreenState createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _ratingCtrl = TextEditingController();
  final _latCtrl = TextEditingController();
  final _lngCtrl = TextEditingController();
  final _photoCtrl = TextEditingController();

  void _saveRestaurant() async {
    if (_formKey.currentState!.validate()) {
      final restaurant = Restaurant(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameCtrl.text,
        address: _addressCtrl.text,
        rating: double.tryParse(_ratingCtrl.text) ?? 0.0,
        lat: double.tryParse(_latCtrl.text) ?? 0.0,
        lng: double.tryParse(_lngCtrl.text) ?? 0.0,
        photoReference: _photoCtrl.text,
      );

      await DBService.addBookmark(restaurant);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Custom restaurant added!')),
      );
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _addressCtrl.dispose();
    _ratingCtrl.dispose();
    _latCtrl.dispose();
    _lngCtrl.dispose();
    _photoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Custom Restaurant')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_nameCtrl, 'Name'),
              _buildTextField(_addressCtrl, 'Address'),
              _buildTextField(_ratingCtrl, 'Rating (0.0 - 5.0)', type: TextInputType.number),
              _buildTextField(_latCtrl, 'Latitude', type: TextInputType.number),
              _buildTextField(_lngCtrl, 'Longitude', type: TextInputType.number),
              _buildTextField(_photoCtrl, 'Photo URL (optional)'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveRestaurant,
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  minimumSize: Size(double.infinity, 48),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) => value == null || value.isEmpty ? 'Required' : null,
      ),
    );
  }
}
