import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/data/services/auth_service.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/college_logo.png',
                    width: 50,
                    height: 50,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'RVVM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context: context,
                  icon: Icons.dashboard_outlined,
                  title: 'Dashboard',
                  onTap: () => context.go('/host'),
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.person_outline,
                  title: 'Profile',
                  onTap: () => context.go('/host/profile'),
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.pending_actions_outlined,
                  title: 'Pending Approvals',
                  onTap: () => context.go('/host/pending-approvals'),
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.check_circle_outline,
                  title: 'Approved Visitors',
                  onTap: () => context.go('/host/approved-visitors'),
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.history,
                  title: 'Visit History',
                  onTap: () => context.go('/host/visit-history'),
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.calendar_today_outlined,
                  title: 'Schedule Meeting',
                  onTap: () => context.go('/host/schedule-meeting'),
                ),
                const Divider(height: 1),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () => ref.read(authProvider.notifier).signOut(),
                  isDestructive: true,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: isDestructive ? Colors.red : AppTheme.primaryColor,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: isDestructive ? Colors.red : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 