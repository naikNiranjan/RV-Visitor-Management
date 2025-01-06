import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/route_utils.dart';
import '../../domain/models/visitor.dart';
import '../../domain/models/department_data.dart';
import '../screens/visitor_success_screen.dart';

const int _maxVisitors = 15;

class VisitorAdditionalDetailsForm extends ConsumerStatefulWidget {
  final Visitor visitor;
  final void Function(Visitor updatedVisitor)? onSubmitted;

  const VisitorAdditionalDetailsForm({
    super.key,
    required this.visitor,
    this.onSubmitted,
  });

  @override
  ConsumerState<VisitorAdditionalDetailsForm> createState() =>
      _VisitorAdditionalDetailsFormState();
}

class _VisitorAdditionalDetailsFormState
    extends ConsumerState<VisitorAdditionalDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  int _numberOfVisitors = 1;
  String? _selectedStaffId;
  String? _selectedDepartmentCode;
  String? _selectedDocumentType;
  String? _photoUrl;
  String? _documentUrl;
  bool _sendNotification = false;

  void _takePhoto() async {
    // TODO: Implement camera functionality
    setState(() {
      _photoUrl = 'dummy_photo_url';
    });
  }

  void _uploadPhoto() async {
    // TODO: Implement file picker functionality
    setState(() {
      _photoUrl = 'dummy_photo_url';
    });
  }

  void _uploadDocument() async {
    // TODO: Implement file picker functionality
    setState(() {
      _documentUrl = 'dummy_document_url';
    });
  }

  void _takeDocumentPhoto() async {
    // TODO: Implement camera functionality for document
    setState(() {
      _documentUrl = 'dummy_document_photo_url';
    });
  }

  void _sendNotificationToHost() async {
    // TODO: Implement notification sending
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Notification sent to host'),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedVisitor = widget.visitor.copyWith(
        numberOfVisitors: _numberOfVisitors,
        whomToMeet: _selectedStaffId!,
        department: _selectedDepartmentCode!,
        documentType: _selectedDocumentType!,
        photoUrl: _photoUrl,
        documentUrl: _documentUrl,
        sendNotification: _sendNotification,
      );

      widget.onSubmitted?.call(updatedVisitor);

      // Navigate to success screen
      Navigator.pushReplacement(
        context,
        RouteUtils.noAnimationRoute(
          VisitorSuccessScreen(
            visitor: updatedVisitor,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final staffList = _selectedDepartmentCode != null
        ? departmentStaff[_selectedDepartmentCode!] ?? []
        : [];

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Additional Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please provide additional information',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Visitor Photo (Optional)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _takePhoto,
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: const Text('Take Photo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.cardBackgroundColor,
                        foregroundColor: AppTheme.primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(
                            color: AppTheme.primaryColor,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _uploadPhoto,
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Upload File'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[50],
                        foregroundColor: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              if (_photoUrl != null) ...[
                const SizedBox(height: 8),
                const Text('Photo uploaded successfully'),
              ],
              const SizedBox(height: 24),
              const Text(
                'Number of Visitors',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _numberOfVisitors > 1
                        ? () => setState(() => _numberOfVisitors--)
                        : null,
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    _numberOfVisitors.toString(),
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: _numberOfVisitors < _maxVisitors
                        ? () => setState(() => _numberOfVisitors++)
                        : null,
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              if (_numberOfVisitors == _maxVisitors) ...[
                const SizedBox(height: 4),
                Text(
                  'Maximum limit reached',
                  style: TextStyle(
                    color: Colors.red[700],
                    fontSize: 12,
                  ),
                ),
              ],
              const SizedBox(height: 24),
              const Text(
                'Visitor Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedDepartmentCode,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Department *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.business),
                ),
                items: departments
                    .map((dept) => DropdownMenuItem<String>(
                          value: dept.value,
                          child: Text(
                            dept.label,
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
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedStaffId,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Whom to Meet *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
                items: allStaff
                    .map((staff) => DropdownMenuItem<String>(
                          value: staff.value,
                          child: Text(
                            staff.label,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedStaffId = value),
                validator: (value) =>
                    value == null ? 'Please select whom to meet' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedDocumentType,
                decoration: const InputDecoration(
                  labelText: 'Document Type *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.document_scanner),
                ),
                items: documentTypes
                    .map((type) => DropdownMenuItem<String>(
                          value: type.value,
                          child: Text(type.label),
                        ))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _selectedDocumentType = value),
                validator: (value) =>
                    value == null ? 'Please select a document type' : null,
              ),
              if (_selectedDocumentType != null) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _takeDocumentPhoto,
                        icon: const Icon(Icons.camera_alt),
                        label: const Text('Take Photo'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[50],
                          foregroundColor: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _uploadDocument,
                        icon: const Icon(Icons.upload_file),
                        label: const Text('Upload File'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[50],
                          foregroundColor: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                if (_documentUrl != null) ...[
                  const SizedBox(height: 8),
                  const Text('Document uploaded successfully'),
                ],
              ],
              const SizedBox(height: 24),
              CheckboxListTile(
                value: _sendNotification,
                onChanged: (bool? value) {
                  setState(() {
                    _sendNotification = value ?? false;
                  });
                },
                title: const Text('Send notification to host'),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit',
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
}
