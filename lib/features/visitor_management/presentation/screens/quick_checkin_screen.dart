import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/responsive_utils.dart';
import 'register_screen.dart';
import 'return_visitor_details_screen.dart';
import '../../../../core/utils/route_utils.dart';
import '../../../../core/widgets/base_screen.dart';

class QuickCheckInScreen extends StatefulWidget {
  const QuickCheckInScreen({super.key});

  @override
  State<QuickCheckInScreen> createState() => _QuickCheckInScreenState();
}

class _QuickCheckInScreenState extends State<QuickCheckInScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter phone number';
    }
    if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }
    return null;
  }

  void _handleCheckIn() {
    if (_formKey.currentState?.validate() ?? false) {
      // This is dummy data - you would normally fetch this from your database
      final visitorData = {
        'name': 'John Doe',
        'phone': _phoneController.text,
        'email': 'john1111.doe@example.com',
        'vehicleNumber': 'KA01AB1234',
      };

      Navigator.push(
        context,
        RouteUtils.noAnimationRoute(
          ReturnVisitorDetailsScreen(
            phoneNumber: _phoneController.text,
            visitorData: visitorData,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = ResponsiveUtils.getHorizontalPadding(screenWidth);

    return BaseScreen(
      title: 'Quick Check-In',
      useCustomAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quick Check-In',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Enter your registered phone number',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildInputField(
                    controller: _phoneController,
                    label: 'Phone Number',
                    prefixIcon: Icons.phone_outlined,
                    validator: _validatePhone,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Container(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('QR Scanner coming soon...'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.qr_code_scanner,
                        size: 24,
                      ),
                      label: const Text(
                        'Scan QR Code',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.primaryColor,
                        side: const BorderSide(
                          color: AppTheme.primaryColor,
                          width: 1,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _handleCheckIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
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
                  const SizedBox(height: 24),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          RouteUtils.noAnimationRoute(
                            const RegisterScreen(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: RichText(
                        text: const TextSpan(
                          text: 'First time visitor? ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(
                              text: 'Register here',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
      ),
    );
  }
}
