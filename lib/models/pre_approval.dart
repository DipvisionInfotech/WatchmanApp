enum PreApprovalType { guest, delivery, cab }

class PreApproval {
  final String id;
  final String name;
  final String mobile;
  final PreApprovalType type;
  final String flatNumber;
  final DateTime expectedDate;
  final String code; // QR code or numeric code

  PreApproval({
    required this.id,
    required this.name,
    required this.mobile,
    required this.type,
    required this.flatNumber,
    required this.expectedDate,
    required this.code,
  });
}
