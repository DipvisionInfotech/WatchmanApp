enum VisitorStatus { pending, approved, rejected, entered, exited }

class Visitor {
  final String id;
  final String name;
  final String mobile;
  final String purpose;
  final String flatNumber;
  final String? photoUrl;
  final DateTime entryTime;
  final DateTime? exitTime;
  final VisitorStatus status;

  Visitor({
    required this.id,
    required this.name,
    required this.mobile,
    required this.purpose,
    required this.flatNumber,
    this.photoUrl,
    required this.entryTime,
    this.exitTime,
    this.status = VisitorStatus.pending,
  });
}
