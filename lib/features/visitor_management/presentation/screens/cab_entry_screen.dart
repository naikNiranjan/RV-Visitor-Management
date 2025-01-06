import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/cab_registration_form.dart';
import '../widgets/custom_app_bar.dart';
import '../../../../core/widgets/base_screen.dart';

class CabEntryScreen extends StatelessWidget {
  const CabEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Cab Entry',
      useCustomAppBar: true,
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: CabRegistrationForm(),
        ),
      ),
    );
  }
}
