import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/delivery.dart';
import '../services/gate_provider.dart';

class DeliveryManagementScreen extends StatefulWidget {
  const DeliveryManagementScreen({super.key});

  @override
  State<DeliveryManagementScreen> createState() => _DeliveryManagementScreenState();
}

class _DeliveryManagementScreenState extends State<DeliveryManagementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _companyController = TextEditingController();
  final _phoneController = TextEditingController();
  final _flatController = TextEditingController();
  DeliveryType _selectedType = DeliveryType.food;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final delivery = Delivery(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        executiveName: _nameController.text,
        company: _companyController.text,
        mobile: _phoneController.text,
        type: _selectedType,
        flatNumber: _flatController.text,
        entryTime: DateTime.now(),
      );

      Provider.of<GateProvider>(context, listen: false).addDelivery(delivery);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DELIVERY ENTRY', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<DeliveryType>(
                value: _selectedType,
                decoration: const InputDecoration(labelText: 'Delivery Type', border: OutlineInputBorder()),
                items: DeliveryType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedType = val!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _companyController,
                decoration: const InputDecoration(labelText: 'Company (Swiggy, Amazon, etc.)', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Please enter company name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Executive Name', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Please enter executive name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Mobile Number', border: OutlineInputBorder()),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _flatController,
                decoration: const InputDecoration(labelText: 'Flat Number', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Please enter flat number' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('NOTIFY RESIDENT'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
