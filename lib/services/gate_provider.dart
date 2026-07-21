import 'package:flutter/material.dart';
import '../models/visitor.dart';
import '../models/staff.dart';
import '../models/delivery.dart';
import '../models/vehicle.dart';
import '../models/notice.dart';

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

  List<Visitor> get visitors => [..._visitors];
  List<Staff> get staffMembers => [..._staffMembers];
  List<Delivery> get deliveries => [..._deliveries];
  List<Vehicle> get vehicles => [..._vehicles];
  List<Notice> get notices => [..._notices];

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
