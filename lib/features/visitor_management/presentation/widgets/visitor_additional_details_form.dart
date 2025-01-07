import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/route_utils.dart';
import '../../domain/models/visitor.dart';
import '../screens/visitor_success_screen.dart';
import '../../../../core/utils/responsive_utils.dart';

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
  final _emailController = TextEditingController();
  final _emergencyNameController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _vehicleController = TextEditingController();
  int _numberOfVisitors = 1;
  String? _photoUrl;
  String? _documentUrl;
  bool _sendNotification = false;

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.visitor.email ?? '';
    _emergencyNameController.text = widget.visitor.emergencyContactName ?? '';
    _emergencyContactController.text =
        widget.visitor.emergencyContactNumber ?? '';
    _vehicleController.text = widget.visitor.vehicleNumber ?? '';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emergencyNameController.dispose();
    _emergencyContactController.dispose();
    _vehicleController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email address';
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
        email: _emailController.text,
        emergencyContactName: _emergencyNameController.text.isEmpty
            ? null
            : _emergencyNameController.text,
        emergencyContactNumber: _emergencyContactController.text.isEmpty
            ? null
            : _emergencyContactController.text,
        vehicleNumber:
            _vehicleController.text.isEmpty ? null : _vehicleController.text,
        numberOfVisitors: _numberOfVisitors,
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
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = ResponsiveUtils.getHorizontalPadding(screenWidth);
    final isCabVisitor = widget.visitor.cabProvider != null;

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding + 8, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Additional Details (Optional)',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please provide any additional information if available',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),
                // Photo Upload Section
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.photo_camera_outlined,
                                color: AppTheme.primaryColor,
                                size: 24,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                isCabVisitor ? 'Driver Photo' : 'Visitor Photo',
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
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildPhotoButton(
                                  icon: Icons.camera_alt_outlined,
                                  label: 'Take Photo',
                                  onPressed: _takePhoto,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildPhotoButton(
                                  icon: Icons.upload_file,
                                  label: 'Upload Photo',
                                  onPressed: _uploadPhoto,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_photoUrl != null)
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 16,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green[600],
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Photo uploaded successfully',
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Regular Fields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: _buildInputField(
                    controller: _emailController,
                    label: 'Email Address',
                    prefixIcon: Icons.email_outlined,
                    validator: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(height: 24),
                if (!isCabVisitor) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _buildInputField(
                      controller: _emergencyNameController,
                      label: 'Emergency Contact Name',
                      prefixIcon: Icons.person_outline,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _buildInputField(
                      controller: _emergencyContactController,
                      label: 'Emergency Contact Number',
                      prefixIcon: Icons.phone_outlined,
                      validator: _validateEmergencyContact,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                if (isCabVisitor) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _buildInputField(
                      controller: _vehicleController,
                      label: 'Vehicle Number',
                      prefixIcon: Icons.directions_car_outlined,
                      textCapitalization: TextCapitalization.characters,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                if (!isCabVisitor) ...[
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
                                Icons.people_outline,
                                color: AppTheme.primaryColor,
                                size: 24,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                'Number of Visitors',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildCounterButton(
                                icon: Icons.remove,
                                onPressed: _numberOfVisitors > 1
                                    ? () => setState(() => _numberOfVisitors--)
                                    : null,
                              ),
                              Container(
                                width: 80,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                child: Text(
                                  _numberOfVisitors.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              _buildCounterButton(
                                icon: Icons.add,
                                onPressed: _numberOfVisitors < _maxVisitors
                                    ? () => setState(() => _numberOfVisitors++)
                                    : null,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
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
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCounterButton({
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: onPressed == null
            ? Colors.grey[100]
            : AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(
              icon,
              color:
                  onPressed == null ? Colors.grey[400] : AppTheme.primaryColor,
              size: 24,
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
        style: const TextStyle(
          fontSize: 16,
        ),
        cursorColor: AppTheme.primaryColor,
        textCapitalization: textCapitalization,
      ),
    );
  }

  Widget _buildPhotoButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryColor,
        elevation: 0,
        side: BorderSide(
          color: AppTheme.primaryColor,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
      ),
    );
  }
}
