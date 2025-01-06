import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/visitor.dart';
import '../../domain/models/department_data.dart';
import '../screens/quick_checkin_success_screen.dart';
import '../../../../core/utils/route_utils.dart';
import '../../../../core/widgets/base_screen.dart';

class ReturnVisitorDetailsScreen extends StatefulWidget {
  final String phoneNumber;
  // This would normally come from your database
  final Map<String, String> visitorData;

  const ReturnVisitorDetailsScreen({
    super.key,
    required this.phoneNumber,
    required this.visitorData,
  });

  @override
  State<ReturnVisitorDetailsScreen> createState() =>
      _ReturnVisitorDetailsScreenState();
}

class _ReturnVisitorDetailsScreenState
    extends State<ReturnVisitorDetailsScreen> {
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

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final visitor = Visitor(
        name: widget.visitorData['name'] ?? '',
        address: widget.visitorData['address'] ?? '',
        contactNumber: widget.visitorData['phone'] ?? '',
        email: widget.visitorData['email'] ?? '',
        vehicleNumber: widget.visitorData['vehicleNumber'],
        purposeOfVisit: _purposeController.text,
        numberOfVisitors: _numberOfVisitors,
        whomToMeet: _selectedStaffId ?? '',
        department: _selectedDepartmentCode ?? '',
        documentType: widget.visitorData['documentType'] ?? '',
        entryTime: DateTime.now(),
        emergencyContactName: null,
        emergencyContactNumber: null,
      );

      Navigator.pushReplacement(
        context,
        RouteUtils.noAnimationRoute(
          QuickCheckInSuccessScreen(
            visitor: visitor,
          ),
        ),
      );
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
                'Additional Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Please provide visit details',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 12),
              Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Visitor Information',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 4),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: const VisualDensity(vertical: -4),
                        minLeadingWidth: 24,
                        leading: const Icon(Icons.person_outline, size: 20),
                        title: Text(widget.visitorData['name'] ?? '',
                            style: const TextStyle(fontSize: 14)),
                        subtitle:
                            const Text('Name', style: TextStyle(fontSize: 12)),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: const VisualDensity(vertical: -4),
                        minLeadingWidth: 24,
                        leading: const Icon(Icons.phone_outlined, size: 20),
                        title: Text(widget.phoneNumber,
                            style: const TextStyle(fontSize: 14)),
                        subtitle:
                            const Text('Phone', style: TextStyle(fontSize: 12)),
                      ),
                      if (widget.visitorData['email'] != null)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          visualDensity: const VisualDensity(vertical: -4),
                          minLeadingWidth: 24,
                          leading: const Icon(Icons.email_outlined, size: 20),
                          title: Text(widget.visitorData['email']!,
                              style: const TextStyle(fontSize: 14)),
                          subtitle: const Text('Email',
                              style: TextStyle(fontSize: 12)),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedDepartmentCode,
                isExpanded: true,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                ),
                dropdownColor: Colors.white,
                decoration: InputDecoration(
                  labelText: 'Department *',
                  labelStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                  prefixIcon: const Icon(
                    Icons.business_outlined,
                    color: AppTheme.iconColor,
                    size: 20,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: AppTheme.cardBackgroundColor,
                ),
                items: departments
                    .map((dept) => DropdownMenuItem<String>(
                          value: dept.value,
                          child: Text(
                            dept.label,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDepartmentCode = value;
                    _selectedStaffId = null;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a department' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedStaffId,
                isExpanded: true,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                ),
                dropdownColor: Colors.white,
                decoration: InputDecoration(
                  labelText: 'Whom to Meet *',
                  labelStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: AppTheme.iconColor,
                    size: 20,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: AppTheme.cardBackgroundColor,
                ),
                items: allStaff
                    .map((staff) => DropdownMenuItem<String>(
                          value: staff.value,
                          child: Text(
                            staff.label,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedStaffId = value),
                validator: (value) =>
                    value == null ? 'Please select whom to meet' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _purposeController,
                decoration: InputDecoration(
                  labelText: 'Purpose of Visit *',
                  prefixIcon: const Icon(
                    Icons.assignment_outlined,
                    color: AppTheme.iconColor,
                  ),
                  hintText: 'Enter purpose of visit',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: AppTheme.cardBackgroundColor,
                ),
                maxLines: 2,
                validator: (value) => value?.isEmpty ?? true
                    ? 'Please enter purpose of visit'
                    : null,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.group_outlined,
                    color: AppTheme.iconColor,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Number of Visitors',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      if (_numberOfVisitors > 1) {
                        setState(() => _numberOfVisitors--);
                      }
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                    color: AppTheme.iconColor,
                    padding: const EdgeInsets.all(4),
                  ),
                  Text(
                    '$_numberOfVisitors',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() => _numberOfVisitors++);
                    },
                    icon: const Icon(Icons.add_circle_outline),
                    color: AppTheme.iconColor,
                    padding: const EdgeInsets.all(4),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              CheckboxListTile(
                value: _sendNotification,
                onChanged: (bool? value) {
                  setState(() {
                    _sendNotification = value ?? false;
                  });
                },
                title: const Text('Send notification to host',
                    style: TextStyle(fontSize: 14)),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: AppTheme.primaryColor,
                contentPadding: EdgeInsets.zero,
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
