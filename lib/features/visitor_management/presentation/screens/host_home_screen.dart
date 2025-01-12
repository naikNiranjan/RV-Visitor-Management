import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/image_carousel.dart';
import '../widgets/app_drawer.dart';

class HostHomeScreen extends ConsumerWidget {
  const HostHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = ResponsiveUtils.getScreenWidth(context);
    final isSmallScreen = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    final crossAxisCount = ResponsiveUtils.isDesktop(context)
        ? screenWidth > 1600
            ? 4
            : 3
        : isTablet
            ? 2
            : 2;

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final childAspectRatio = isLandscape ? 1.4 : 1.0;

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ImageCarousel(),
              const SizedBox(height: 20),
              Padding(
                padding: ResponsiveUtils.getResponsivePadding(context),
                child: GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: isSmallScreen ? 12 : 16,
                    crossAxisSpacing: isSmallScreen ? 12 : 16,
                    childAspectRatio: childAspectRatio,
                  ),
                  children: [
                    _buildDashboardCard(
                      context: context,
                      title: 'Pending Approvals',
                      subtitle: 'Review visitor requests',
                      icon: Icons.pending_actions,
                      onTap: () {
                        // TODO: Navigate to pending approvals
                      },
                    ),
                    _buildDashboardCard(
                      context: context,
                      title: 'Approved Visitors',
                      subtitle: 'View approved visitors',
                      icon: Icons.check_circle,
                      onTap: () {
                        // TODO: Navigate to approved visitors
                      },
                    ),
                    _buildDashboardCard(
                      context: context,
                      title: 'Schedule Meeting',
                      subtitle: 'Plan future visits',
                      icon: Icons.calendar_today,
                      onTap: () {
                        // TODO: Navigate to schedule meeting
                      },
                    ),
                    _buildDashboardCard(
                      context: context,
                      title: 'Visit History',
                      subtitle: 'Past visitor records',
                      icon: Icons.history,
                      onTap: () {
                        // TODO: Navigate to visit history
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: isSmallScreen ? 16 : 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final isSmallScreen = ResponsiveUtils.isMobile(context);

    return DashboardCard(
      title: title,
      subtitle: subtitle,
      icon: icon,
      onTap: onTap,
      titleStyle: TextStyle(
        fontSize: ResponsiveUtils.getResponsiveFontSize(
          context,
          baseFontSize: isSmallScreen ? 14 : 16,
        ),
        fontWeight: FontWeight.w600,
      ),
      subtitleStyle: TextStyle(
        fontSize: ResponsiveUtils.getResponsiveFontSize(
          context,
          baseFontSize: isSmallScreen ? 12 : 14,
        ),
        color: Colors.grey[600],
      ),
    );
  }
} 