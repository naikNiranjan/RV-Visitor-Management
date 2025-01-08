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
  String? _selectedCabProvider;
  String? _selectedDepartmentCode;
  String? _selectedStaffId;

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
        vehicleNumber: _vehicleController.text,
        purposeOfVisit: _purposeController.text,
        numberOfVisitors: 1,
        whomToMeet: _selectedStaffId ?? '',
        department: _selectedDepartmentCode ?? '',
        documentType: '',
        entryTime: DateTime.now(),
        cabProvider: _selectedCabProvider,
        driverName: _driverNameController.text,
        driverContact: _driverContactController.text,
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
                const SizedBox(height: 16),
                _buildInputField(
                  controller: _vehicleController,
                  label: 'Vehicle Number',
                  prefixIcon: Icons.directions_car_outlined,
                  textCapitalization: TextCapitalization.characters,
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
                    _selectedStaffId = null; // Reset staff selection when department changes
                  });
                  },
                  validator: (value) => value == null ? 'Please select a department' : null,
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
                      ?.toList() ??
                    [],
                  onChanged: _selectedDepartmentCode == null
                    ? null
                    : (value) => setState(() => _selectedStaffId = value),
                  validator: (value) => value == null ? 'Please select whom to meet' : null,
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
