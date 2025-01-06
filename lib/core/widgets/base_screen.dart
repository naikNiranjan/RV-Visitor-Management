import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../../features/visitor_management/presentation/widgets/app_drawer.dart';
import '../../features/visitor_management/presentation/widgets/custom_app_bar.dart';

class BaseScreen extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final FloatingActionButton? floatingActionButton;
  final bool useCustomAppBar;
  final bool showBackButton;

  const BaseScreen({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.useCustomAppBar = false,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: useCustomAppBar
          ? CustomAppBar(showBackButton: showBackButton)
          : AppBar(
              title: Text(title),
              backgroundColor: Colors.white,
              foregroundColor: AppTheme.primaryColor,
              elevation: 0,
              actions: actions,
              leading: showBackButton
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  : null,
            ),
      drawer: !showBackButton ? const AppDrawer() : null,
      body: SafeArea(
        child: body,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
