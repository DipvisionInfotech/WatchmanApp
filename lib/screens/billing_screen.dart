import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/gate_provider.dart';
import '../models/bill.dart';
import 'package:intl/intl.dart';

class BillingScreen extends StatelessWidget {
  const BillingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GateProvider>(context);
    final bills = provider.bills;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Society Billing'),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            color: Colors.blue.shade900,
            child: Column(
              children: [
                const Text('Total Outstanding', style: TextStyle(color: Colors.white70, fontSize: 16)),
                const SizedBox(height: 8),
                Text('₹${provider.totalDues}', style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.blue.shade900),
                  child: const Text('PAY ALL DUES'),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: bills.length,
              itemBuilder: (context, index) {
                final bill = bills[index];
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.receipt_long)),
                  title: Text(bill.title),
                  subtitle: Text('Due: ${DateFormat('dd MMM yyyy').format(bill.dueDate)}'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('₹${bill.amount}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(bill.status.name.toUpperCase(), style: TextStyle(color: bill.status == BillStatus.paid ? Colors.green : Colors.red, fontSize: 10)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
