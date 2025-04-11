import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../services/db_service.dart';

class EditRestaurantScreen extends StatefulWidget {
  final Restaurant restaurant;

  const EditRestaurantScreen({super.key, required this.restaurant});

  @override
  _EditRestaurantScreenState createState() => _EditRestaurantScreenState();
}

class _EditRestaurantScreenState extends State<EditRestaurantScreen> {
  late TextEditingController _nameCtrl;
  late TextEditingController _addressCtrl;
  late TextEditingController _ratingCtrl;
  late TextEditingController _latCtrl;
  late TextEditingController _lngCtrl;
  late TextEditingController _photoCtrl;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final r = widget.restaurant;
    _nameCtrl = TextEditingController(text: r.name);
    _addressCtrl = TextEditingController(text: r.address);
    _ratingCtrl = TextEditingController(text: r.rating.toString());
    _latCtrl = TextEditingController(text: r.lat.toString());
    _lngCtrl = TextEditingController(text: r.lng.toString());
    _photoCtrl = TextEditingController(text: r.photoReference);
    super.initState();
  }

  void _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      final updated = Restaurant(
        id: widget.restaurant.id,
        name: _nameCtrl.text,
        address: _addressCtrl.text,
        rating: double.tryParse(_ratingCtrl.text) ?? 0.0,
        lat: double.tryParse(_latCtrl.text) ?? 0.0,
        lng: double.tryParse(_lngCtrl.text) ?? 0.0,
        photoReference: _photoCtrl.text,
      );

      await DBService.updateBookmark(updated);
      Navigator.pop(context, true);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Restaurant updated!')),
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
      appBar: AppBar(title: Text('Edit Restaurant')),
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
                onPressed: _saveChanges,
                child: Text('Update'),
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
