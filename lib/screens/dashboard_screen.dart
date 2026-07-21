import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../services/gate_provider.dart';
import 'visitor_entry_screen.dart';
import 'staff_management_screen.dart';
import 'delivery_management_screen.dart';
import 'vehicle_entry_screen.dart';
import 'logs_screen.dart';
import 'reports_screen.dart';
import 'notices_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WATCHMAN DASHBOARD', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.campaign), 
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NoticesScreen())),
          ),
          IconButton(icon: const Icon(Icons.logout), onPressed: () => Navigator.pop(context)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuickStats(context),
            const SizedBox(height: 24),
            Text('Gate Operations', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildMenuCard(
                  context,
                  'New Visitor',
                  Icons.person_add,
                  Colors.orange,
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const VisitorEntryScreen())),
                ),
                _buildMenuCard(
                  context,
                  'Delivery',
                  Icons.delivery_dining,
                  Colors.blue,
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DeliveryManagementScreen())),
                ),
                _buildMenuCard(
                  context,
                  'Vehicle Entry',
                  Icons.directions_car,
                  Colors.teal,
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const VehicleEntryScreen())),
                ),
                _buildMenuCard(
                  context,
                  'Staff Attendance',
                  Icons.badge,
                  Colors.green,
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StaffManagementScreen())),
                ),
                _buildMenuCard(
                  context,
                  'Activity Logs',
                  Icons.history,
                  Colors.purple,
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LogsScreen())),
                ),
                _buildMenuCard(
                  context,
                  'Daily Reports',
                  Icons.analytics,
                  Colors.indigo,
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportsScreen())),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildEmergencySection(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    final provider = Provider.of<GateProvider>(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem('Visitors', provider.visitors.length.toString()),
          _statItem('Deliveries', provider.deliveries.length.toString()),
          _statItem('Staff In', provider.staffMembers.where((s) => s.isCheckedIn).length.toString()),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 2, blurRadius: 5)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.1),
              radius: 30,
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(height: 12),
            Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencySection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.warning, color: Colors.red),
              SizedBox(width: 8),
              Text('EMERGENCY SOS', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
            child: const Text('TRIGGER ALARM'),
          ),
        ],
      ),
    );
  }
}
