import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/gate_provider.dart';

class AmenityBookingScreen extends StatelessWidget {
  const AmenityBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final amenities = Provider.of<GateProvider>(context).amenities;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Amenities'),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: amenities.length,
        itemBuilder: (context, index) {
          final amenity = amenities[index];
          return Card(
            child: ListTile(
              leading: Icon(amenity.icon, size: 32, color: Colors.blue.shade900),
              title: Text(amenity.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(amenity.description),
              trailing: ElevatedButton(
                onPressed: amenity.isAvailable ? () {} : null,
                child: Text(amenity.isAvailable ? 'Book' : 'Full'),
              ),
            ),
          );
        },
      ),
    );
  }
}
