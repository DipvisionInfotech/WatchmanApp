enum StaffType { maid, cook, driver, electrician, plumber, other }

class Staff {
  final String id;
  final String name;
  final String mobile;
  final StaffType type;
  final String? photoUrl;
  final bool isCheckedIn;
  final DateTime? lastCheckIn;

  Staff({
    required this.id,
    required this.name,
    required this.mobile,
    required this.type,
    this.photoUrl,
    this.isCheckedIn = false,
    this.lastCheckIn,
  });
}
