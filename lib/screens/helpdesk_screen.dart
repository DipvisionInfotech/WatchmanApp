import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/gate_provider.dart';
import '../models/complaint.dart';
import 'package:intl/intl.dart';

class HelpdeskScreen extends StatelessWidget {
  const HelpdeskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final complaints = Provider.of<GateProvider>(context).complaints;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Helpdesk & Tickets'),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
      ),
      body: complaints.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.assignment_outlined, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  const Text('No active complaints', style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: complaints.length,
              itemBuilder: (context, index) {
                final complaint = complaints[index];
                return Card(
                  child: ListTile(
                    title: Text(complaint.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(complaint.category),
                        Text('Raised on: ${DateFormat('dd MMM yyyy').format(complaint.createdAt)}', style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                    trailing: Chip(
                      label: Text(complaint.status.name.toUpperCase(), style: const TextStyle(fontSize: 10, color: Colors.white)),
                      backgroundColor: _getStatusColor(complaint.status),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNewTicketDialog(context),
        backgroundColor: Colors.blue.shade900,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Color _getStatusColor(ComplaintStatus status) {
    switch (status) {
      case ComplaintStatus.open: return Colors.orange;
      case ComplaintStatus.inProgress: return Colors.blue;
      case ComplaintStatus.resolved: return Colors.green;
      case ComplaintStatus.closed: return Colors.grey;
    }
  }

  void _showNewTicketDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    String category = 'Maintenance';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Raise New Ticket'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Issue Title')),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: category,
                items: ['Maintenance', 'Security', 'Billing', 'Amenity', 'Other']
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) => category = val!,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 8),
              TextField(controller: descController, decoration: const InputDecoration(labelText: 'Description'), maxLines: 3),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                Provider.of<GateProvider>(context, listen: false).addComplaint(
                  Complaint(
                    id: DateTime.now().toString(),
                    title: titleController.text,
                    description: descController.text,
                    category: category,
                    createdAt: DateTime.now(),
                  ),
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
