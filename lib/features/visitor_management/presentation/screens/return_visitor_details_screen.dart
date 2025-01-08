import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/visitor.dart';
import '../../domain/models/department_data.dart';
import '../screens/quick_checkin_success_screen.dart';
import '../../../../core/utils/route_utils.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../data/services/firebase_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/firebase_provider.dart';

class ReturnVisitorDetailsScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  final Map<String, dynamic> visitorData;

  const ReturnVisitorDetailsScreen({
    super.key,
    required this.phoneNumber,
    required this.visitorData,
  });

  @override
  ConsumerState<ReturnVisitorDetailsScreen> createState() =>
      _ReturnVisitorDetailsScreenState();
}

class _ReturnVisitorDetailsScreenState
    extends ConsumerState<ReturnVisitorDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  int _numberOfVisitors = 1;
  String? _selectedStaffId;
  String? _selectedDepartmentCode;
  final _purposeController = TextEditingController();
  bool _sendNotification = false;

  @override
  void dispose() {
    _purposeController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final visitor = Visitor(
          name: widget.visitorData['name'] ?? '',
          address: widget.visitorData['address'] ?? '',
          contactNumber: widget.visitorData['contactNumber'] ?? '',
          email: widget.visitorData['email'] ?? '',
          vehicleNumber: widget.visitorData['vehicleNumber'],
          documentType: widget.visitorData['documentType'] ?? '',
          purposeOfVisit: _purposeController.text,
          numberOfVisitors: _numberOfVisitors,
          whomToMeet: _selectedStaffId ?? '',
          department: _selectedDepartmentCode ?? '',
          entryTime: DateTime.now(),
          type: 'return',
          sendNotification: _sendNotification,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Processing check-in...'),
              duration: Duration(seconds: 1),
            ),
          );
        }

        await ref.read(firebaseServiceProvider).saveReturnVisit(visitor);

        if (mounted) {
          Navigator.pushReplacement(
            context,
            RouteUtils.noAnimationRoute(
              QuickCheckInSuccessScreen(visitor: visitor),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error during check-in: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Check-in Details',
      showBackButton: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Previous visitor details found',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16),
              // Visitor Information Card
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Previous Visit Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _buildDetailRow('Name', widget.visitorData['name'] as String),
                          _buildDetailRow('Phone', widget.visitorData['contactNumber'] as String),
                          _buildDetailRow('Email', widget.visitorData['email'] as String),
                          if (widget.visitorData['address'] != null)
                            _buildDetailRow('Address', widget.visitorData['address'] as String),
                          if (widget.visitorData['department'] != null)
                            _buildDetailRow('Department', widget.visitorData['department'] as String),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedDepartmentCode,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: 'Department *',
                  labelStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: departments.map((dept) {
                  return DropdownMenuItem(
                    value: dept.value,
                    child: Text(
                      dept.label,
                      style: const TextStyle(fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDepartmentCode = value;
                    _selectedStaffId = null;
                  });
                },
                validator: (value) => value == null ? 'Please select department' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedStaffId,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: 'Whom to Meet *',
                  labelStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: _selectedDepartmentCode == null
                    ? []
                    : departmentStaff[_selectedDepartmentCode]?.map((staff) {
                        return DropdownMenuItem(
                          value: staff.value,
                          child: Text(
                            staff.label,
                            style: const TextStyle(fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList() ?? [],
                onChanged: (value) {
                  setState(() {
                    _selectedStaffId = value;
                  });
                },
                validator: (value) => value == null ? 'Please select staff' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _purposeController,
                decoration: InputDecoration(
                  labelText: 'Purpose of Visit *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) => value?.isEmpty ?? true
                    ? 'Please enter purpose of visit'
                    : null,
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                value: _sendNotification,
                onChanged: (value) {
                  setState(() {
                    _sendNotification = value ?? false;
                  });
                },
                title: const Text('Send notification to host'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Check In',
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
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
