import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: 'Information We Collect',
            content:
                'We collect information that you provide directly to us, including:'
                '\n\n• Name and contact information'
                '\n• Government-issued ID details'
                '\n• Vehicle information (if applicable)'
                '\n• Purpose of visit'
                '\n• Photos taken during registration',
          ),
          const SizedBox(height: 24),
          _buildSection(
            title: 'How We Use Your Information',
            content: 'The information we collect is used for:'
                '\n\n• Visitor identification and verification'
                '\n• Security and access control'
                '\n• Communication with hosts'
                '\n• Emergency contact purposes'
                '\n• Statistical analysis and reporting',
          ),
          const SizedBox(height: 24),
          _buildSection(
            title: 'Data Security',
            content:
                'We implement appropriate security measures to protect your personal information. '
                'This includes encryption, secure storage, and restricted access to visitor data.',
          ),
          const SizedBox(height: 24),
          _buildSection(
            title: 'Data Retention',
            content:
                'We retain visitor information for a period of 1 year from the date of visit. '
                'After this period, the data is automatically deleted from our systems.',
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
