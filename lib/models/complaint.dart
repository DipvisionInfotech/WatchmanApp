enum ComplaintStatus { open, inProgress, resolved, closed }

class Complaint {
  final String id;
  final String title;
  final String description;
  final String category;
  final DateTime createdAt;
  final ComplaintStatus status;

  Complaint({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.createdAt,
    this.status = ComplaintStatus.open,
  });
}
