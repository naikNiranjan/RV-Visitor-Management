import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import '../../domain/models/visitor.dart';
import '../../../../core/theme/app_theme.dart';
import 'package:lottie/lottie.dart';

class VisitorSuccessScreen extends StatefulWidget {
  final Visitor visitor;

  const VisitorSuccessScreen({
    super.key,
    required this.visitor,
  });

  @override
  State<VisitorSuccessScreen> createState() => _VisitorSuccessScreenState();
}

class _VisitorSuccessScreenState extends State<VisitorSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;

  String get _visitorQrData {
    final Map<String, dynamic> qrData = {
      'name': widget.visitor.name,
      'address': widget.visitor.address,
      'contactNumber': widget.visitor.contactNumber,
      'email': widget.visitor.email,
      'vehicleNumber': widget.visitor.vehicleNumber,
      'purposeOfVisit': widget.visitor.purposeOfVisit,
      'numberOfVisitors': widget.visitor.numberOfVisitors,
      'whomToMeet': widget.visitor.whomToMeet,
      'department': widget.visitor.department,
      'documentType': widget.visitor.documentType,
      'entryTime': widget.visitor.entryTime?.toIso8601String(),
      'visitorId': widget.visitor.entryTime?.millisecondsSinceEpoch
          .toString()
          .substring(5),
    };
    return json.encode(qrData);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
    ));

    _controller.forward().then((_) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _showSuccessAnimation = false;
          });
        }
      });
    });
  }

  bool _showSuccessAnimation = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              if (_showSuccessAnimation)
                Lottie.asset(
                  'assets/animations/success.json',
                  width: 200,
                  height: 200,
                  controller: _controller,
                  repeat: false,
                ),
              if (!_showSuccessAnimation) const SizedBox(height: 200),
              const SizedBox(height: 24),
              FadeTransition(
                opacity: _fadeInAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    children: [
                      const Text(
                        'Registration Successful!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Visitor ID: ${widget.visitor.entryTime?.millisecondsSinceEpoch.toString().substring(5)}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: QrImageView(
                          data: _visitorQrData,
                          version: QrVersions.auto,
                          size: 200.0,
                          backgroundColor: Colors.white,
                          eyeStyle: const QrEyeStyle(
                            eyeShape: QrEyeShape.square,
                            color: AppTheme.primaryColor,
                          ),
                          dataModuleStyle: const QrDataModuleStyle(
                            dataModuleShape: QrDataModuleShape.square,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildDetailCard(
                        title: 'Visitor Details',
                        icon: Icons.person,
                        details: [
                          DetailItem('Name', widget.visitor.name),
                          DetailItem('Address', widget.visitor.address),
                          DetailItem('Contact', widget.visitor.contactNumber),
                          DetailItem('Email', widget.visitor.email),
                          if (widget.visitor.vehicleNumber != null)
                            DetailItem(
                                'Vehicle', widget.visitor.vehicleNumber!),
                          DetailItem('Purpose', widget.visitor.purposeOfVisit),
                          DetailItem('Visitors',
                              widget.visitor.numberOfVisitors.toString()),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildDetailCard(
                        title: 'Meeting Details',
                        icon: Icons.business,
                        details: [
                          DetailItem('Department', widget.visitor.department),
                          DetailItem('Host', widget.visitor.whomToMeet),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildDetailCard(
                        title: 'Document Details',
                        icon: Icons.document_scanner,
                        details: [
                          DetailItem('Type', widget.visitor.documentType),
                          if (widget.visitor.documentUrl != null)
                            DetailItem('Status', 'Uploaded'),
                        ],
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/',
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Back to Home',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard({
    required String title,
    required IconData icon,
    required List<DetailItem> details,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: AppTheme.primaryColor,
                ),
                const SizedBox(width: 8),
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
              children: details.map((detail) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          '${detail.label}:',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          detail.value,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailItem {
  final String label;
  final String value;

  DetailItem(this.label, this.value);
}
