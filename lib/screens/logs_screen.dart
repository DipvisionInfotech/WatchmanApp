import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../services/gate_provider.dart';
import '../models/visitor.dart';

class LogsScreen extends StatelessWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GateProvider>(context);
    final visitors = provider.visitors;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('ACTIVITY LOGS', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
          backgroundColor: Colors.blue.shade900,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'VISITORS'),
              Tab(text: 'DELIVERIES'),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            _buildVisitorLogs(visitors, provider),
            _buildDeliveryLogs(provider.deliveries),
          ],
        ),
      ),
    );
  }

  Widget _buildVisitorLogs(List<Visitor> visitors, GateProvider provider) {
    if (visitors.isEmpty) {
      return const Center(child: Text('No visitor logs found'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: visitors.length,
      itemBuilder: (context, index) {
        final visitor = visitors[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            title: Text(visitor.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Flat: ${visitor.flatNumber} • ${visitor.purpose}'),
                Text(
                  'Entry: ${DateFormat('hh:mm a').format(visitor.entryTime)}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            trailing: visitor.status == VisitorStatus.entered
                ? ElevatedButton(
                    onPressed: () => provider.updateVisitorStatus(visitor.id, VisitorStatus.exited),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade100, foregroundColor: Colors.orange),
                    child: const Text('EXIT'),
                  )
                : Text(
                    visitor.status.name.toUpperCase(),
                    style: TextStyle(
                      color: visitor.status == VisitorStatus.approved ? Colors.green : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildDeliveryLogs(deliveries) {
    if (deliveries.isEmpty) {
      return const Center(child: Text('No delivery logs found'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: deliveries.length,
      itemBuilder: (context, index) {
        final delivery = deliveries[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const Icon(Icons.delivery_dining, color: Colors.blue),
            title: Text(delivery.company, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Flat: ${delivery.flatNumber} • ${delivery.executiveName}'),
            trailing: Text(DateFormat('hh:mm a').format(delivery.entryTime)),
          ),
        );
      },
    );
  }
}
