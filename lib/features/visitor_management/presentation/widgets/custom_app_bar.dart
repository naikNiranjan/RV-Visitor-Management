import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppTheme.primaryColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : IconButton(
              icon: const Icon(
                Icons.menu,
                color: AppTheme.primaryColor,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
      title: const Text(
        'RVVM',
        style: TextStyle(
          color: AppTheme.primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CircleAvatar(
            backgroundColor: AppTheme.cardBackgroundColor,
            child: Image.asset(
              'assets/images/college_logo.png',
              width: 24,
              height: 24,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
