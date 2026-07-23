import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/gate_provider.dart';
import '../models/pre_approval.dart';
import 'package:intl/intl.dart';

class PreApprovalScreen extends StatelessWidget {
  const PreApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final preApprovals = Provider.of<GateProvider>(context).preApprovals;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Visitor Pre-approval'),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
      ),
      body: preApprovals.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.qr_code_scanner, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  const Text('No pre-approvals found', style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: preApprovals.length,
              itemBuilder: (context, index) {
                final item = preApprovals[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade50,
                      child: Icon(_getIcon(item.type), color: Colors.blue.shade900),
                    ),
                    title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Code: ${item.code} • ${DateFormat('dd MMM').format(item.expectedDate)}'),
                    trailing: Text(item.type.name.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddPreApproval(context),
        backgroundColor: Colors.blue.shade900,
        label: const Text('Pre-approve', style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  IconData _getIcon(PreApprovalType type) {
    switch (type) {
      case PreApprovalType.guest: return Icons.person;
      case PreApprovalType.delivery: return Icons.delivery_dining;
      case PreApprovalType.cab: return Icons.local_taxi;
    }
  }

  void _showAddPreApproval(BuildContext context) {
    final nameController = TextEditingController();
    PreApprovalType type = PreApprovalType.guest;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Pre-approval'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
            const SizedBox(height: 8),
            DropdownButtonFormField<PreApprovalType>(
              value: type,
              items: PreApprovalType.values.map((t) => DropdownMenuItem(value: t, child: Text(t.name.toUpperCase()))).toList(),
              onChanged: (val) => type = val!,
              decoration: const InputDecoration(labelText: 'Type'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty) {
                Provider.of<GateProvider>(context, listen: false).addPreApproval(
                  PreApproval(
                    id: DateTime.now().toString(),
                    name: nameController.text,
                    mobile: '',
                    type: type,
                    flatNumber: '101',
                    expectedDate: DateTime.now(),
                    code: (1000 + (DateTime.now().millisecond % 9000)).toString(),
                  ),
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Generate Code'),
          ),
        ],
      ),
    );
  }
}
