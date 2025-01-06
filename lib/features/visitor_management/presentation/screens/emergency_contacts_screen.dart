import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class EmergencyContactsScreen extends StatelessWidget {
  const EmergencyContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Contacts'),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildEmergencyCard(
            title: 'Security Office',
            phone: '+91 80 2861 2445',
            subPhone: '+91 80 2861 2444',
            description: 'Main Gate Security (24/7)',
            icon: Icons.security,
          ),
          const SizedBox(height: 16),
          _buildEmergencyCard(
            title: 'Medical Emergency',
            phone: '108',
            subPhone: '+91 80 2861 2446',
            description: 'Campus Medical Center (9 AM - 5 PM)',
            icon: Icons.medical_services,
          ),
          const SizedBox(height: 16),
          _buildEmergencyCard(
            title: 'Fire Emergency',
            phone: '101',
            subPhone: '+91 80 2861 2447',
            description: 'Fire Safety Office (24/7)',
            icon: Icons.fire_truck,
          ),
          const SizedBox(height: 16),
          _buildEmergencyCard(
            title: 'Police',
            phone: '100',
            subPhone: '+91 80 2861 2448',
            description: 'Campus Police Post (24/7)',
            icon: Icons.local_police,
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyCard({
    required String title,
    required String phone,
    required String subPhone,
    required String description,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: AppTheme.primaryColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildPhoneRow(
                  phone: phone,
                  isMain: true,
                ),
                const SizedBox(height: 8),
                _buildPhoneRow(
                  phone: subPhone,
                  isMain: false,
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneRow({
    required String phone,
    required bool isMain,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: isMain ? Colors.green[50] : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isMain ? Colors.green[100]! : Colors.grey[200]!,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.phone,
            size: 20,
            color: isMain ? Colors.green[700] : Colors.grey[700],
          ),
          const SizedBox(width: 8),
          Text(
            phone,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isMain ? Colors.green[700] : Colors.grey[700],
            ),
          ),
          const Spacer(),
          Icon(
            Icons.call,
            size: 20,
            color: isMain ? Colors.green[700] : Colors.grey[700],
          ),
        ],
      ),
    );
  }
}
