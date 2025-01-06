import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class TermsServiceScreen extends StatelessWidget {
  const TermsServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: 'Acceptance of Terms',
            content:
                'By accessing and using the RVCE Visitor Management System, '
                'you agree to be bound by these Terms of Service and all applicable laws and regulations.',
          ),
          const SizedBox(height: 24),
          _buildSection(
            title: 'Visitor Registration',
            content:
                '• All visitors must provide accurate and complete information\n'
                '• Valid government-issued ID is required for entry\n'
                '• Visitors must comply with all campus security protocols\n'
                '• Photography and recording may be restricted in certain areas',
          ),
          const SizedBox(height: 24),
          _buildSection(
            title: 'Code of Conduct',
            content: 'Visitors must:\n\n'
                '• Follow all campus rules and regulations\n'
                '• Respect college property and facilities\n'
                '• Maintain appropriate behavior\n'
                '• Follow safety and security guidelines',
          ),
          const SizedBox(height: 24),
          _buildSection(
            title: 'Prohibited Activities',
            content: '• Unauthorized access to restricted areas\n'
                '• Sharing access credentials\n'
                '• Misuse of visitor passes\n'
                '• Any illegal or disruptive activities',
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
