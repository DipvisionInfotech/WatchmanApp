import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/gate_provider.dart';
import 'visitor_entry_screen.dart';
import 'staff_management_screen.dart';
import 'delivery_management_screen.dart';
import 'vehicle_entry_screen.dart';
import 'logs_screen.dart';
import 'reports_screen.dart';
import 'notices_screen.dart';
import 'billing_screen.dart';
import 'amenity_booking_screen.dart';
import 'helpdesk_screen.dart';
import 'pre_approval_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOCIETY MANAGEMENT', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
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
            
            _buildSectionTitle('1. Smart Security & Gate'),
            _buildFeatureGrid(context, [
              _Feature(
                'Pre-approval', 
                Icons.verified_user, 
                Colors.orange, 
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PreApprovalScreen()))
              ),
              _Feature(
                'Visitor Entry', 
                Icons.person_add, 
                Colors.orange, 
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => const VisitorEntryScreen()))
              ),
              _Feature(
                'Delivery', 
                Icons.delivery_dining, 
                Colors.orange, 
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DeliveryManagementScreen()))
              ),
              _Feature(
                'Safety Alerts', 
                Icons.pets, 
                Colors.orange, 
                () => _showPlaceholder(context, 'Child & Pet Safety')
              ),
            ]),

            const SizedBox(height: 24),
            _buildSectionTitle('2. Accounting & Billing'),
            _buildFeatureGrid(context, [
              _Feature(
                'Payments', 
                Icons.account_balance_wallet, 
                Colors.green, 
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BillingScreen()))
              ),
              _Feature(
                'Invoices', 
                Icons.receipt_long, 
                Colors.green, 
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => const BillingScreen()))
              ),
              _Feature(
                'Vendors', 
                Icons.storefront, 
                Colors.green, 
                () => _showPlaceholder(context, 'Vendor Management')
              ),
              _Feature(
                'Meter', 
                Icons.electric_bolt, 
                Colors.green, 
                () => _showPlaceholder(context, 'Prepaid Meter')
              ),
            ]),

            const SizedBox(height: 24),
            _buildSectionTitle('3. Daily Help Management'),
            _buildFeatureGrid(context, [
              _Feature(
                'Attendance', 
                Icons.badge, 
                Colors.blue, 
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StaffManagementScreen()))
              ),
              _Feature(
                'Help Ratings', 
                Icons.star_half, 
                Colors.blue, 
                () => _showPlaceholder(context, 'Staff Ratings & Reviews')
              ),
              _Feature(
                'Staff Salary', 
                Icons.payments, 
                Colors.blue, 
                () => _showPlaceholder(context, 'Salary Tracking')
              ),
            ]),

            const SizedBox(height: 24),
            _buildSectionTitle('4. Community & Facilities'),
            _buildFeatureGrid(context, [
              _Feature(
                'Helpdesk', 
                Icons.support_agent, 
                Colors.purple, 
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpdeskScreen()))
              ),
              _Feature(
                'Bookings', 
                Icons.event_available, 
                Colors.purple, 
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AmenityBookingScreen()))
              ),
              _Feature(
                'Intercom', 
                Icons.phone_callback, 
                Colors.purple, 
                () => _showPlaceholder(context, 'Secure Internet Calling')
              ),
              _Feature(
                'Logs/Reports', 
                Icons.analytics, 
                Colors.purple, 
                () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LogsScreen()))
              ),
            ]),

            const SizedBox(height: 24),
            _buildEmergencySection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title, 
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue.shade900)
      ),
    );
  }

  Widget _buildFeatureGrid(BuildContext context, List<_Feature> features) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final f = features[index];
        return InkWell(
          onTap: f.onTap,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: f.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(f.icon, color: f.color, size: 24),
              ),
              const SizedBox(height: 4),
              Text(
                f.title, 
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPlaceholder(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title feature coming soon!'), duration: const Duration(seconds: 1))
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
        Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
      ],
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

class _Feature {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  _Feature(this.title, this.icon, this.color, this.onTap);
}
