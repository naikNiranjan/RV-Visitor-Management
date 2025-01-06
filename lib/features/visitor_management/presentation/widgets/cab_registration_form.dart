import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/route_utils.dart';
import '../../domain/models/visitor.dart';
import '../providers/visitor_form_provider.dart';
import '../screens/visitor_success_screen.dart';
import 'cab_additional_details_form.dart';
import '../../../../core/widgets/base_screen.dart';

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
  final _vehicleController = TextEditingController();
  final _purposeController = TextEditingController();
  final _driverNameController = TextEditingController();
  final _driverContactController = TextEditingController();
  final _emailController = TextEditingController();
  String? _selectedCabProvider;

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

  String? _validateVehicle(String? value) {
    // Remove validation since it's optional
    return null;
  }

  String? _validatePurpose(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter purpose of visit';
    }
    return null;
  }

  String? _validateDriverContact(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Optional field
    }
    if (value.length != 10) {
      return 'Contact number must be 10 digits';
    }
    return null;
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

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final visitor = Visitor(
        name: _nameController.text,
        address: _addressController.text,
        contactNumber: _contactController.text,
        email: _emailController.text,
        vehicleNumber: _vehicleController.text,
        purposeOfVisit: _purposeController.text,
        numberOfVisitors: 1,
        whomToMeet: '',
        department: '',
        documentType: 'N/A',
        entryTime: DateTime.now(),
        cabProvider: _selectedCabProvider,
        driverName: _driverNameController.text.isEmpty
            ? null
            : _driverNameController.text,
        driverContact: _driverContactController.text.isEmpty
            ? null
            : _driverContactController.text,
        emergencyContactName: null,
        emergencyContactNumber: null,
        photoUrl: null,
        documentUrl: null,
      );

      // Navigate to additional details
      Navigator.push(
        context,
        RouteUtils.noAnimationRoute(
          BaseScreen(
            title: 'Additional Details',
            showBackButton: true,
            body: SingleChildScrollView(
              child: CabAdditionalDetailsForm(
                visitor: visitor,
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cab Entry Registration',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please fill in the cab and visitor details',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          _buildInputField(
            controller: _nameController,
            label: 'Name of Visitor',
            prefixIcon: Icons.person_outline,
            validator: _validateName,
            hintText: 'Enter visitor name',
          ),
          const SizedBox(height: 16),
          _buildInputField(
            controller: _addressController,
            label: 'Address',
            prefixIcon: Icons.location_on_outlined,
            validator: _validateAddress,
            hintText: 'Enter address',
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
            hintText: 'Enter contact number',
          ),
          const SizedBox(height: 16),
          _buildInputField(
            controller: _emailController,
            label: 'Email Address',
            prefixIcon: Icons.email_outlined,
            validator: _validateEmail,
            keyboardType: TextInputType.emailAddress,
            hintText: 'Enter email address',
          ),
          const SizedBox(height: 16),
          _buildInputField(
            controller: _vehicleController,
            label: 'Vehicle Number (Optional)',
            prefixIcon: Icons.directions_car_outlined,
            validator: _validateVehicle,
            hintText: 'Enter vehicle number (e.g., KA01AB1234)',
            textCapitalization: TextCapitalization.characters,
          ),
          const SizedBox(height: 16),
          _buildInputField(
            controller: _purposeController,
            label: 'Purpose of Visit',
            prefixIcon: Icons.assignment_outlined,
            validator: _validatePurpose,
            maxLines: 2,
            hintText: 'Enter purpose of visit',
          ),
          const SizedBox(height: 24),
          const Text(
            'Cab Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedCabProvider,
            decoration: InputDecoration(
              labelText: 'Cab Provider',
              prefixIcon: const Icon(
                Icons.local_taxi_outlined,
                color: AppTheme.iconColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: AppTheme.cardBackgroundColor,
            ),
            items: _cabProviders.map((provider) {
              return DropdownMenuItem(
                value: provider,
                child: Text(provider),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCabProvider = value;
              });
            },
            validator: (value) =>
                value == null ? 'Please select a cab provider' : null,
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
            hintText: 'Enter driver name if available',
          ),
          const SizedBox(height: 16),
          _buildInputField(
            controller: _driverContactController,
            label: 'Driver Contact Number',
            prefixIcon: Icons.phone_outlined,
            validator: _validateDriverContact,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            hintText: 'Enter driver contact number if available',
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
        color: AppTheme.cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[200]!,
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
            color: AppTheme.iconColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppTheme.cardBackgroundColor,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
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
