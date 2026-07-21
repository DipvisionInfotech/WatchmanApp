class Vehicle {
  final String id;
  final String vehicleNumber;
  final String vehicleType; // Car, Bike, etc.
  final String ownerName;
  final String flatNumber;
  final DateTime entryTime;
  final DateTime? exitTime;

  Vehicle({
    required this.id,
    required this.vehicleNumber,
    required this.vehicleType,
    required this.ownerName,
    required this.flatNumber,
    required this.entryTime,
    this.exitTime,
  });
}
