import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/route_utils.dart';
import '../../domain/models/visitor.dart';
import '../screens/visitor_success_screen.dart';
import '../../domain/models/department_data.dart';

class CabAdditionalDetailsForm extends ConsumerStatefulWidget {
  final Visitor visitor;

  const CabAdditionalDetailsForm({
    super.key,
    required this.visitor,
  });

  @override
  ConsumerState<CabAdditionalDetailsForm> createState() =>
      _CabAdditionalDetailsFormState();
}

class _CabAdditionalDetailsFormState
    extends ConsumerState<CabAdditionalDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedDepartmentCode;
  String? _selectedStaffId;
  bool _sendNotification = false;
  String? _photoUrl;
  String? _documentUrl;

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedVisitor = widget.visitor.copyWith(
        department: _selectedDepartmentCode ?? 'N/A',
        whomToMeet: _selectedStaffId ?? 'N/A',
        sendNotification: _sendNotification,
        photoUrl: _photoUrl,
        documentUrl: _documentUrl,
      );

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
              'Please provide department and staff details',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: _selectedDepartmentCode,
              decoration: InputDecoration(
                labelText: 'Department *',
                prefixIcon: const Icon(
                  Icons.business_outlined,
                  color: AppTheme.iconColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: AppTheme.cardBackgroundColor,
              ),
              items: departments
                  .map((dept) => DropdownMenuItem<String>(
                        value: dept.value,
                        child: Text(dept.label),
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
            const SizedBox(height: 24),
            const Text(
              'Visitor Photo (Optional)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _takePhoto,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Take Photo'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.secondaryButtonColor,
                      foregroundColor: AppTheme.secondaryButtonTextColor,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _uploadPhoto,
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Upload Photo'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.secondaryButtonColor,
                      foregroundColor: AppTheme.secondaryButtonTextColor,
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
              'Document',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _takeDocumentPhoto,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Take Photo'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.secondaryButtonColor,
                      foregroundColor: AppTheme.secondaryButtonTextColor,
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
                      backgroundColor: AppTheme.secondaryButtonColor,
                      foregroundColor: AppTheme.secondaryButtonTextColor,
                    ),
                  ),
                ),
              ],
            ),
            if (_documentUrl != null) ...[
              const SizedBox(height: 8),
              const Text('Document uploaded successfully'),
            ],
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: _selectedStaffId,
              decoration: InputDecoration(
                labelText: 'Whom to Meet *',
                prefixIcon: const Icon(
                  Icons.person_outline,
                  color: AppTheme.iconColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: AppTheme.cardBackgroundColor,
              ),
              items: allStaff
                  .map((staff) => DropdownMenuItem<String>(
                        value: staff.value,
                        child: Text(staff.label),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _selectedStaffId = value),
              validator: (value) =>
                  value == null ? 'Please select whom to meet' : null,
            ),
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
              activeColor: AppTheme.primaryColor,
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
    );
  }
}
