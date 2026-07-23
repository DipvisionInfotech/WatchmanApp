import 'package:flutter/material.dart';

class Amenity {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final bool isAvailable;

  Amenity({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    this.isAvailable = true,
  });
}

class AmenityBooking {
  final String id;
  final String amenityId;
  final String residentName;
  final DateTime startTime;
  final DateTime endTime;
  final String status; // pending, confirmed, cancelled

  AmenityBooking({
    required this.id,
    required this.amenityId,
    required this.residentName,
    required this.startTime,
    required this.endTime,
    required this.status,
  });
}
