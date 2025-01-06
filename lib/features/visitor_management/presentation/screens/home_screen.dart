import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/image_carousel.dart';
import '../widgets/app_drawer.dart';
import 'quick_checkin_screen.dart';
import 'cab_entry_screen.dart';
import 'approval_status_screen.dart';
import 'todays_visitors_screen.dart';
import 'document_screen.dart';
import 'register_screen.dart';

class VisitorManagementScreen extends ConsumerWidget {
  const VisitorManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = ResponsiveUtils.getScreenWidth(context);
    final isSmallScreen = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    // Dynamic grid calculations
    final crossAxisCount = ResponsiveUtils.isDesktop(context)
        ? screenWidth > 1600
            ? 5 // Extra large screens
            : 4 // Normal desktop
        : isTablet
            ? screenWidth > 900
                ? 3 // Large tablets
                : 2 // Regular tablets
            : 2; // Mobile

    // Dynamic aspect ratio based on screen size and orientation
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final childAspectRatio = isLandscape ? 1.4 : 1.0;

    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Image Carousel with responsive height
                  SizedBox(
                    width: constraints.maxWidth,
                    child: const ImageCarousel(),
                  ),
                  const SizedBox(height: 20),
                  // Dashboard Grid
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
                          title: 'Quick Check-In',
                          subtitle: 'Fast track visitor entry',
                          icon: Icons.flash_on,
                          onTap: () =>
                              _navigateTo(context, const QuickCheckInScreen()),
                        ),
                        _buildDashboardCard(
                          context: context,
                          title: 'Register',
                          subtitle: 'New visitor entry',
                          icon: Icons.person_add,
                          onTap: () =>
                              _navigateTo(context, const RegisterScreen()),
                        ),
                        _buildDashboardCard(
                          context: context,
                          title: 'Cab Entry',
                          subtitle: 'Register campus cabs',
                          icon: Icons.local_taxi,
                          onTap: () =>
                              _navigateTo(context, const CabEntryScreen()),
                        ),
                        _buildDashboardCard(
                          context: context,
                          title: 'Approval Status',
                          subtitle: 'View pending requests',
                          icon: Icons.access_time,
                          onTap: () => _navigateTo(
                              context, const ApprovalStatusScreen()),
                        ),
                        _buildDashboardCard(
                          context: context,
                          title: "Today's Visitors",
                          subtitle: 'View active visitors',
                          icon: Icons.people,
                          onTap: () => _navigateTo(
                              context, const TodaysVisitorsScreen()),
                        ),
                        _buildDashboardCard(
                          context: context,
                          title: 'Document',
                          subtitle: 'See All Documents',
                          icon: Icons.document_scanner,
                          onTap: () =>
                              _navigateTo(context, const DocumentScreen()),
                        ),
                      ],
                    ),
                  ),
                  // Bottom padding for scrolling
                  SizedBox(height: isSmallScreen ? 16 : 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
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
