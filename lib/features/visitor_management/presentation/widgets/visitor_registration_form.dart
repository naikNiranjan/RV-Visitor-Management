import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/route_utils.dart';
import '../../domain/models/visitor.dart';
import '../../domain/models/department_data.dart';
import '../providers/visitor_form_provider.dart';
import '../widgets/visitor_additional_details_form.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/utils/responsive_utils.dart';

class VisitorRegistrationForm extends ConsumerStatefulWidget {
  final void Function(Visitor visitor)? onSubmitted;

  const VisitorRegistrationForm({
    super.key,
    this.onSubmitted,
  });

  @override
  ConsumerState<VisitorRegistrationForm> createState() =>
      _VisitorRegistrationFormState();
}

class _VisitorRegistrationFormState
    extends ConsumerState<VisitorRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();
  final _purposeController = TextEditingController();
  String? _selectedDepartmentCode;
  String? _selectedStaffId;
  String? _selectedDocumentType;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _contactController.dispose();
    _purposeController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter visitor name';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter address';
    }
    return null;
  }

  String? _validateContact(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter contact number';
    }
    if (value.length != 10) {
      return 'Contact number must be 10 digits';
    }
    return null;
  }

  String? _validatePurpose(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter purpose of visit';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final visitor = Visitor(
        name: _nameController.text,
        address: _addressController.text,
        contactNumber: _contactController.text,
        email: '',
        vehicleNumber: null,
        purposeOfVisit: _purposeController.text,
        numberOfVisitors: 1,
        whomToMeet: _selectedStaffId ?? '',
        department: _selectedDepartmentCode ?? '',
        documentType: _selectedDocumentType ?? '',
        entryTime: DateTime.now(),
      );

      Navigator.push(
        context,
        RouteUtils.noAnimationRoute(
          BaseScreen(
            title: 'Additional Details',
            showBackButton: true,
            body: SingleChildScrollView(
              child: VisitorAdditionalDetailsForm(
                visitor: visitor,
                onSubmitted: (updatedVisitor) {
                  ref
                      .read(visitorFormProvider.notifier)
                      .submitVisitor(updatedVisitor);
                  widget.onSubmitted?.call(updatedVisitor);
                },
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = ResponsiveUtils.getHorizontalPadding(screenWidth);

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Visitor Registration',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please fill in the visitor details',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                _buildInputField(
                  controller: _nameController,
                  label: 'Full Name',
                  prefixIcon: Icons.person_outline,
                  validator: _validateName,
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  controller: _addressController,
                  label: 'Address',
                  prefixIcon: Icons.location_on_outlined,
                  validator: _validateAddress,
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  controller: _contactController,
                  label: 'Contact Number',
                  prefixIcon: Icons.phone_outlined,
                  validator: _validateContact,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  controller: _purposeController,
                  label: 'Purpose of Visit',
                  prefixIcon: Icons.assignment_outlined,
                  validator: _validatePurpose,
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedDepartmentCode,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Department *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.business_outlined,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  menuMaxHeight: 300,
                  items: departments.map((department) {
                    return DropdownMenuItem(
                      value: department.value,
                      child: Text(
                        department.label,
                        overflow: TextOverflow.ellipsis,
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
                      value == null ? 'Please select a department' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedStaffId,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Whom to Meet *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  menuMaxHeight: 300,
                  items: allStaff.map((staff) {
                    return DropdownMenuItem(
                      value: staff.value,
                      child: Text(
                        staff.label,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      setState(() => _selectedStaffId = value),
                  validator: (value) =>
                      value == null ? 'Please select whom to meet' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedDocumentType,
                  decoration: const InputDecoration(
                    labelText: 'Document Type *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.document_scanner,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  items: documentTypes.map((type) {
                    return DropdownMenuItem(
                      value: type.value,
                      child: Text(type.label),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      setState(() => _selectedDocumentType = value),
                  validator: (value) =>
                      value == null ? 'Please select a document type' : null,
                ),
                const SizedBox(height: 16),
                if (_selectedDocumentType != null) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth < 400) {
                          // Stack buttons vertically on narrow screens
                          return Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    // Implement take photo functionality
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    size: 20,
                                    color: AppTheme.primaryColor,
                                  ),
                                  label: const Text('Take Photo'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: AppTheme.primaryColor,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    elevation: 0,
                                    side: const BorderSide(
                                      color: AppTheme.primaryColor,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    // Implement upload file functionality
                                  },
                                  icon: const Icon(
                                    Icons.upload_file,
                                    size: 20,
                                    color: AppTheme.primaryColor,
                                  ),
                                  label: const Text('Upload File'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: AppTheme.primaryColor,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    elevation: 0,
                                    side: const BorderSide(
                                      color: AppTheme.primaryColor,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        // Side by side buttons for wider screens
                        return Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Implement take photo functionality
                                },
                                icon: const Icon(
                                  Icons.camera_alt,
                                  size: 20,
                                  color: AppTheme.primaryColor,
                                ),
                                label: const Text('Take Photo'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: AppTheme.primaryColor,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  elevation: 0,
                                  side: const BorderSide(
                                    color: AppTheme.primaryColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Implement upload file functionality
                                },
                                icon: const Icon(
                                  Icons.upload_file,
                                  size: 20,
                                  color: AppTheme.primaryColor,
                                ),
                                label: const Text('Upload File'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: AppTheme.primaryColor,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  elevation: 0,
                                  side: const BorderSide(
                                    color: AppTheme.primaryColor,
                                    width: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
                const SizedBox(height: 24),
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
                      'Next',
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
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData prefixIcon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int? maxLines,
    String? hintText,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          constraints: BoxConstraints(
            maxWidth: constraints.maxWidth,
            minHeight: 56,
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              hintText: hintText,
              prefixIcon: Icon(
                prefixIcon,
                color: AppTheme.primaryColor,
                size: 20,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
            ),
            validator: validator,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            maxLines: maxLines ?? 1,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.primaryTextColor,
            ),
          ),
        );
      },
    );
  }
}
