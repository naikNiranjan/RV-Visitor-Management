import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/department_data.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/route_utils.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../domain/models/visitor.dart';
import '../providers/visitor_form_provider.dart';
import '../screens/visitor_success_screen.dart';
import 'dart:io';
import './camera_screen.dart';
import 'package:file_picker/file_picker.dart';

class CabRegistrationForm extends ConsumerStatefulWidget {
  const CabRegistrationForm({super.key});

  @override
  ConsumerState<CabRegistrationForm> createState() =>
      _CabRegistrationFormState();
}

class _CabRegistrationFormState extends ConsumerState<CabRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();
  final _purposeController = TextEditingController();
  final _vehicleController = TextEditingController();
  final _driverNameController = TextEditingController();
  final _driverContactController = TextEditingController();
  final _emailController = TextEditingController();
  final _emergencyNameController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  String? _selectedCabProvider;
  String? _selectedDepartmentCode;
  String? _selectedStaffId;
  File? _photoFile;
  String? _photoUrl;
  File? _documentFile;
  String? _documentUrl;
  String? _selectedDocumentType;
  bool _sendNotification = false;

  final List<String> _cabProviders = [
    'Uber',
    'Ola',
    'Meru',
    'Other',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _contactController.dispose();
    _vehicleController.dispose();
    _purposeController.dispose();
    _driverNameController.dispose();
    _driverContactController.dispose();
    _emailController.dispose();
    _emergencyNameController.dispose();
    _emergencyContactController.dispose();
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

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Optional field
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      caseSensitive: false,
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateEmergencyContact(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Optional field
    }
    if (value.length != 10) {
      return 'Contact number must be 10 digits';
    }
    return null;
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
      final visitor = Visitor(
        name: _nameController.text,
        address: _addressController.text,
        contactNumber: _contactController.text,
        email: _emailController.text.isEmpty ? '' : _emailController.text,
        vehicleNumber: _vehicleController.text,
        purposeOfVisit: _purposeController.text,
        numberOfVisitors: 1,
        whomToMeet: _selectedStaffId ?? '',
        department: _selectedDepartmentCode ?? '',
        documentType: _selectedDocumentType ?? '',
        entryTime: DateTime.now(),
        cabProvider: _selectedCabProvider,
        driverName: _driverNameController.text.isEmpty
            ? null
            : _driverNameController.text,
        driverContact: _driverContactController.text.isEmpty
            ? null
            : _driverContactController.text,
        photoUrl: _photoUrl,
        documentUrl: _documentUrl,
        emergencyContactName: _emergencyNameController.text.isEmpty
            ? null
            : _emergencyNameController.text,
        emergencyContactNumber: _emergencyContactController.text.isEmpty
            ? null
            : _emergencyContactController.text,
        sendNotification: _sendNotification,
      );

      ref.read(visitorFormProvider.notifier).submitVisitor(visitor);

      Navigator.push(
        context,
        RouteUtils.noAnimationRoute(
          VisitorSuccessScreen(visitor: visitor),
        ),
      );
    }
  }

  Future<void> _takePhoto() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(
          onPhotoTaken: (String path) {
            setState(() {
              _photoFile = File(path);
              _photoUrl = path;
            });
          },
        ),
      ),
    );
  }

  Future<void> _takeDocumentPhoto() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(
          onPhotoTaken: (String path) {
            setState(() {
              _documentFile = File(path);
              _documentUrl = path;
            });
          },
        ),
      ),
    );
  }

  Future<void> _uploadPhoto() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _photoFile = File(result.files.single.path!);
          _photoUrl = result.files.single.path;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SelectableText.rich(
              TextSpan(
                text: 'Error picking file: ',
                children: [
                  TextSpan(
                    text: e.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _uploadDocument() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        allowMultiple: false,
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _documentFile = File(result.files.single.path!);
          _documentUrl = result.files.single.path;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SelectableText.rich(
              TextSpan(
                text: 'Error picking file: ',
                children: [
                  TextSpan(
                    text: e.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Widget _buildPhotoPreview(File? file) {
    if (file == null) return const SizedBox.shrink();

    final extension = file.path.split('.').last.toLowerCase();
    final isImage = ['jpg', 'jpeg', 'png'].contains(extension);

    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isImage)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                file,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Error loading image'),
                    ),
                  );
                },
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.file_present),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      file.path.split('/').last,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.primaryTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      if (file == _photoFile) {
                        _photoFile = null;
                        _photoUrl = null;
                      } else {
                        _documentFile = null;
                        _documentUrl = null;
                      }
                    });
                  },
                  icon: const Icon(Icons.delete_outline, size: 20),
                  label: const Text('Remove'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
                  'Cab Registration',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please fill in the cab entry details',
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
                      _selectedStaffId =
                          null; // Reset staff selection when department changes
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
                  items: _selectedDepartmentCode == null
                      ? []
                      : departmentStaff[_selectedDepartmentCode]
                              ?.map((staff) => DropdownMenuItem(
                                    value: staff.value,
                                    child: Text(
                                      staff.label,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ))
                              .toList() ??
                          [],
                  onChanged: _selectedDepartmentCode == null
                      ? null
                      : (value) => setState(() => _selectedStaffId = value),
                  validator: (value) =>
                      value == null ? 'Please select whom to meet' : null,
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  controller: _vehicleController,
                  label: 'Vehicle Number *',
                  hintText: 'e.g., KA-01-AB-1234',
                  prefixIcon: Icons.directions_car_outlined,
                  textCapitalization: TextCapitalization.characters,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Please enter vehicle number'
                      : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedCabProvider,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Cab Provider *',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.local_taxi_outlined,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  items: _cabProviders.map((provider) {
                    return DropdownMenuItem(
                      value: provider,
                      child: Text(
                        provider,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      setState(() => _selectedCabProvider = value),
                  validator: (value) =>
                      value == null ? 'Please select a cab provider' : null,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Additional Details (Optional)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  controller: _emailController,
                  label: 'Email Address',
                  prefixIcon: Icons.email_outlined,
                  validator: _validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  controller: _emergencyNameController,
                  label: 'Emergency Contact Name',
                  prefixIcon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  controller: _emergencyContactController,
                  label: 'Emergency Contact Number',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  validator: _validateEmergencyContact,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Driver Details (Optional)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  controller: _driverNameController,
                  label: 'Driver Name',
                  prefixIcon: Icons.person_outline,
                ),
                const SizedBox(height: 16),
                _buildInputField(
                  controller: _driverContactController,
                  label: 'Driver Contact',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                ),
                const SizedBox(height: 24),
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
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppTheme.borderColor,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.document_scanner_outlined,
                                color: AppTheme.primaryColor,
                                size: 24,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                'Identity Document',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: _takeDocumentPhoto,
                                      icon: const Icon(Icons.camera_alt),
                                      label: const Text('Take Photo'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: AppTheme.primaryColor,
                                        elevation: 0,
                                        side: BorderSide(
                                          color: AppTheme.primaryColor,
                                        ),
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
                                        backgroundColor: Colors.white,
                                        foregroundColor: AppTheme.primaryColor,
                                        elevation: 0,
                                        side: BorderSide(
                                          color: AppTheme.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (_documentFile != null)
                                _buildPhotoPreview(_documentFile),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppTheme.borderColor,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.notifications_outlined,
                              color: AppTheme.primaryColor,
                              size: 24,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Notification',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
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
                          contentPadding: EdgeInsets.zero,
                        ),
                        if (_sendNotification) ...[
                          const SizedBox(height: 8),
                          Text(
                            'The host will be notified when the visitor arrives.',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
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
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.borderColor,
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          prefixIcon: Icon(
            prefixIcon,
            color: AppTheme.primaryColor,
            size: 24,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppTheme.borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppTheme.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppTheme.primaryColor),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          labelStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
        ),
        validator: validator,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLines: maxLines ?? 1,
        textCapitalization: textCapitalization,
        style: const TextStyle(
          fontSize: 16,
        ),
        cursorColor: AppTheme.primaryColor,
      ),
    );
  }
}
