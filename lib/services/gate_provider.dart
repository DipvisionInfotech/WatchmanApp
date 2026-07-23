import 'package:flutter/material.dart';
import '../models/visitor.dart';
import '../models/staff.dart';
import '../models/delivery.dart';
import '../models/vehicle.dart';
import '../models/notice.dart';
import '../models/bill.dart';
import '../models/amenity.dart';
import '../models/pre_approval.dart';
import '../models/complaint.dart';

class GateProvider with ChangeNotifier {
  final List<Visitor> _visitors = [];
  final List<Staff> _staffMembers = [
    Staff(id: '1', name: 'Ramesh Singh', mobile: '9876543210', type: StaffType.maid),
    Staff(id: '2', name: 'Suresh Kumar', mobile: '9876543211', type: StaffType.driver),
  ];
  final List<Delivery> _deliveries = [];
  final List<Vehicle> _vehicles = [];
  final List<Notice> _notices = [
    Notice(
      id: '1',
      title: 'Monthly Maintenance',
      content: 'Society maintenance is scheduled for Sunday, 25th July.',
      date: DateTime.now(),
    ),
    Notice(
      id: '2',
      title: 'New Parking Rules',
      content: 'Please ensure all visitor vehicles are parked in the designated zone.',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  final List<Bill> _bills = [
    Bill(id: '1', title: 'July Maintenance', amount: 2500, dueDate: DateTime(2026, 7, 31), status: BillStatus.unpaid),
    Bill(id: '2', title: 'Water Bill', amount: 450, dueDate: DateTime(2026, 7, 25), status: BillStatus.unpaid),
  ];

  final List<Amenity> _amenities = [
    Amenity(id: '1', name: 'Clubhouse', description: 'Available for events', icon: Icons.meeting_room),
    Amenity(id: '2', name: 'Swimming Pool', description: 'Open 6 AM - 10 PM', icon: Icons.pool),
    Amenity(id: '3', name: 'Gym', description: '24/7 Access', icon: Icons.fitness_center),
  ];

  final List<PreApproval> _preApprovals = [];
  final List<Complaint> _complaints = [];

  List<Visitor> get visitors => [..._visitors];
  List<Staff> get staffMembers => [..._staffMembers];
  List<Delivery> get deliveries => [..._deliveries];
  List<Vehicle> get vehicles => [..._vehicles];
  List<Notice> get notices => [..._notices];
  List<Bill> get bills => [..._bills];
  List<Amenity> get amenities => [..._amenities];
  List<PreApproval> get preApprovals => [..._preApprovals];
  List<Complaint> get complaints => [..._complaints];

  double get totalDues => _bills.where((b) => b.status != BillStatus.paid).fold(0, (sum, item) => sum + item.amount);

  void addBill(Bill bill) {
    _bills.add(bill);
    notifyListeners();
  }

  void addComplaint(Complaint complaint) {
    _complaints.add(complaint);
    notifyListeners();
  }

  void addPreApproval(PreApproval preApproval) {
    _preApprovals.add(preApproval);
    notifyListeners();
  }

  void addVehicle(Vehicle vehicle) {
    _vehicles.add(vehicle);
    notifyListeners();
  }

  void addVisitor(Visitor visitor) {
    _visitors.add(visitor);
    notifyListeners();
  }

  void updateVisitorStatus(String id, VisitorStatus status) {
    final index = _visitors.indexWhere((v) => v.id == id);
    if (index != -1) {
      final v = _visitors[index];
      _visitors[index] = Visitor(
        id: v.id,
        name: v.name,
        mobile: v.mobile,
        purpose: v.purpose,
        flatNumber: v.flatNumber,
        photoUrl: v.photoUrl,
        entryTime: v.entryTime,
        exitTime: status == VisitorStatus.exited ? DateTime.now() : v.exitTime,
        status: status,
      );
      notifyListeners();
    }
  }

  void addDelivery(Delivery delivery) {
    _deliveries.add(delivery);
    notifyListeners();
  }

  void toggleStaffCheckIn(String id) {
    final index = _staffMembers.indexWhere((s) => s.id == id);
    if (index != -1) {
      final s = _staffMembers[index];
      _staffMembers[index] = Staff(
        id: s.id,
        name: s.name,
        mobile: s.mobile,
        type: s.type,
        photoUrl: s.photoUrl,
        isCheckedIn: !s.isCheckedIn,
        lastCheckIn: !s.isCheckedIn ? DateTime.now() : s.lastCheckIn,
      );
      notifyListeners();
    }
  }
}
