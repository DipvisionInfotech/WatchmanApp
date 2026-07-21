enum DeliveryType { food, courier, parcel, grocery, other }

class Delivery {
  final String id;
  final String executiveName;
  final String company;
  final String mobile;
  final DeliveryType type;
  final String flatNumber;
  final DateTime entryTime;
  final DateTime? exitTime;

  Delivery({
    required this.id,
    required this.executiveName,
    required this.company,
    required this.mobile,
    required this.type,
    required this.flatNumber,
    required this.entryTime,
    this.exitTime,
  });
}
