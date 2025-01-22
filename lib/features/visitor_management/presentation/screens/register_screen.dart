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

class VisitorRegistrationForm extends StatefulWidget {
  const VisitorRegistrationForm({super.key});

  @override
  _VisitorRegistrationFormState createState() => _VisitorRegistrationFormState();
}

class _VisitorRegistrationFormState extends State<VisitorRegistrationForm> {
  bool _sendNotificationRequest = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CheckboxListTile(
            title: const Text('Send Notification Request'),
            value: _sendNotificationRequest,
            onChanged: (bool? value) {
              setState(() {
                _sendNotificationRequest = value ?? false;
              });
            },
          ),
          ElevatedButton(
            onPressed: () {
              // Call registerVisitor with _sendNotificationRequest
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
