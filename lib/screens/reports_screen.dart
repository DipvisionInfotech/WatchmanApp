import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../services/gate_provider.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GateProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('DAILY REPORTS', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildReportCard('Total Visitors Today', provider.visitors.length.toString(), Icons.people, Colors.orange),
            _buildReportCard('Deliveries Handled', provider.deliveries.length.toString(), Icons.delivery_dining, Colors.blue),
            _buildReportCard('Staff Present', provider.staffMembers.where((s) => s.isCheckedIn).length.toString(), Icons.badge, Colors.green),
            _buildReportCard('Vehicles Logged', provider.vehicles.length.toString(), Icons.directions_car, Colors.teal),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(String title, String count, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: Text(
          count,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
        ),
      ),
    );
  }
}
