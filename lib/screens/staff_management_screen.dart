import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../services/gate_provider.dart';
import '../models/staff.dart';

class StaffManagementScreen extends StatelessWidget {
  const StaffManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GateProvider>(context);
    final staff = provider.staffMembers;

    return Scaffold(
      appBar: AppBar(
        title: Text('STAFF ATTENDANCE', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: staff.length,
        itemBuilder: (context, index) {
          final person = staff[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: Text(person.name[0]),
              ),
              title: Text(person.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${person.type.name.toUpperCase()} • ${person.mobile}'),
              trailing: ElevatedButton(
                onPressed: () => provider.toggleStaffCheckIn(person.id),
                style: ElevatedButton.styleFrom(
                  backgroundColor: person.isCheckedIn ? Colors.red.shade100 : Colors.green.shade100,
                  foregroundColor: person.isCheckedIn ? Colors.red : Colors.green,
                  elevation: 0,
                ),
                child: Text(person.isCheckedIn ? 'OUT' : 'IN'),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue.shade900,
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }
}
