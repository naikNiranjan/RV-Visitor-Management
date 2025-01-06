import 'package:flutter/material.dart';
import '../widgets/visitor_registration_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Visitor'),
      ),
      body: const SingleChildScrollView(
        child: VisitorRegistrationForm(),
      ),
    );
  }
}
