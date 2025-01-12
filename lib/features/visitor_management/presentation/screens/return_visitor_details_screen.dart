import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/visitor.dart';
import '../../domain/models/department_data.dart';
import '../screens/quick_checkin_success_screen.dart';
import '../../../../core/utils/route_utils.dart';
import '../../../../core/widgets/base_screen.dart';
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
  final int _numberOfVisitors = 1;
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
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Processing check-in...'),
              duration: Duration(seconds: 1),
            ),
          );
        }

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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryColor.withOpacity(0.1),
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.person_outline_rounded,
                          color: AppTheme.primaryColor,
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Previous visitor details found',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Previous Visit Details Card
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.grey[200]!),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.history_rounded, 
                            color: AppTheme.primaryColor),
                          const SizedBox(width: 8),
                          const Text(
                            'Previous Visit Details',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _buildDetailRow('Name', 
                            widget.visitorData['name'] as String, 
                            Icons.person_outline),
                          _buildDetailRow('Phone', 
                            widget.visitorData['contactNumber'] as String, 
                            Icons.phone_outlined),
                          _buildDetailRow('Email', 
                            widget.visitorData['email'] as String, 
                            Icons.email_outlined),
                          if (widget.visitorData['address'] != null)
                            _buildDetailRow('Address', 
                              widget.visitorData['address'] as String, 
                              Icons.location_on_outlined),
                          if (widget.visitorData['department'] != null)
                            _buildDetailRow('Department', 
                              widget.visitorData['department'] as String, 
                              Icons.business_outlined),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Form Fields
              Text(
                'New Visit Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 16),
              
              // Department Dropdown
              DropdownButtonFormField<String>(
                value: _selectedDepartmentCode,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: 'Department *',
                  prefixIcon: const Icon(Icons.business_outlined),
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
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
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDepartmentCode = value;
                    _selectedStaffId = null;
                  });
                },
                validator: (value) => 
                  value == null ? 'Please select department' : null,
              ),
              const SizedBox(height: 16),

              // Staff Dropdown
              DropdownButtonFormField<String>(
                value: _selectedStaffId,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: 'Whom to Meet *',
                  prefixIcon: const Icon(Icons.person_search_outlined),
                  labelStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
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
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList() ?? [],
                onChanged: (value) {
                  setState(() {
                    _selectedStaffId = value;
                  });
                },
                validator: (value) => 
                  value == null ? 'Please select staff' : null,
              ),
              const SizedBox(height: 16),

              // Purpose TextField
              TextFormField(
                controller: _purposeController,
                decoration: InputDecoration(
                  labelText: 'Purpose of Visit *',
                  prefixIcon: const Icon(Icons.assignment_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) => value?.isEmpty ?? true
                    ? 'Please enter purpose of visit'
                    : null,
              ),
              const SizedBox(height: 16),

              // Notification Checkbox
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey[200]!),
                ),
                child: CheckboxListTile(
                  value: _sendNotification,
                  onChanged: (value) {
                    setState(() {
                      _sendNotification = value ?? false;
                    });
                  },
                  title: const Text('Send notification to host'),
                  secondary: const Icon(Icons.notifications_outlined),
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text(
                    'Check In',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 8),
          Expanded(
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
          ),
        ],
      ),
    );
  }
}
