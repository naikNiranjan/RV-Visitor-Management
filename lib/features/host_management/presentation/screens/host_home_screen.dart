import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/app_drawer.dart';
import '../../../visitor_management/presentation/widgets/image_carousel.dart';
import '../providers/host_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HostHomeScreen extends HookConsumerWidget {
  final Widget child;

  const HostHomeScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const AppDrawer(),
      body: child, // This will display the nested route content
    );
  }
}

class HostDashboard extends HookConsumerWidget {
  const HostDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = ResponsiveUtils.getScreenWidth(context);
    final isSmallScreen = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);
    final currentHost = ref.watch(currentHostProvider);

    return SafeArea(
      child: currentHost.when(
        data: (host) {
          if (host == null) {
            return const Center(child: Text('Host data not found'));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back,',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        host.name,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Text(
                        host.department,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),

                const ImageCarousel(),

                // Quick Stats
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quick Stats',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildQuickStat(
                                context,
                                'Total Visitors',
                                host.numberOfVisitors.toString(),
                                Icons.people,
                              ),
                              _buildQuickStat(
                                context,
                                'Security Level',
                                host.securityLevel,
                                Icons.security,
                              ),
                              _buildQuickStat(
                                context,
                                'Role',
                                host.role,
                                Icons.badge,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Main Dashboard Cards
                Padding(
                  padding: ResponsiveUtils.getResponsivePadding(context),
                  child: GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveUtils.isDesktop(context)
                          ? screenWidth > 1600
                              ? 4
                              : 3
                          : isTablet
                              ? 2
                              : 2,
                      mainAxisSpacing: isSmallScreen ? 12 : 16,
                      crossAxisSpacing: isSmallScreen ? 12 : 16,
                      childAspectRatio: MediaQuery.of(context).orientation ==
                              Orientation.landscape
                          ? 1.4
                          : 1.0,
                    ),
                    children: [
                      _buildDashboardCard(
                        context: context,
                        title: 'Pending Approvals',
                        subtitle: 'Review visitor requests',
                        icon: Icons.pending_actions,
                        count: ref.watch(pendingApprovalsCountProvider),
                        route: 'pending-approvals',
                        color: Colors.orange,
                      ),
                      _buildDashboardCard(
                        context: context,
                        title: 'Approved Visitors',
                        subtitle: 'View approved visitors',
                        icon: Icons.check_circle,
                        count: ref.watch(approvedVisitorsCountProvider),
                        route: 'approved-visitors',
                        color: Colors.green,
                      ),
                      _buildDashboardCard(
                        context: context,
                        title: 'Schedule Meeting',
                        subtitle: 'Plan future visits',
                        icon: Icons.calendar_today,
                        route: 'schedule-meeting',
                        color: Colors.blue,
                      ),
                      _buildDashboardCard(
                        context: context,
                        title: 'Visit History',
                        subtitle: 'Past visitor records',
                        icon: Icons.history,
                        count: ref.watch(visitHistoryCountProvider),
                        route: 'visit-history',
                        color: Colors.purple,
                      ),
                    ],
                  ),
                ),

                // Notifications Section
                if (!isSmallScreen) ...[
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildNotificationsSection(context, ref),
                  ),
                ],

                SizedBox(height: isSmallScreen ? 16 : 24),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: SelectableText.rich(
            TextSpan(
              text: 'Error: $error',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildNotificationsSection(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(hostNotificationsProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Notifications',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to notifications page
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            notifications.when(
              data: (notifs) {
                if (notifs.isEmpty) {
                  return const Center(
                    child: Text('No notifications'),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: notifs.length > 5 ? 5 : notifs.length,
                  itemBuilder: (context, index) {
                    final notif = notifs[index];
                    final timestamp = notif['createdAt'] as Timestamp?;
                    final dateTime = timestamp?.toDate();

                    return ListTile(
                      leading: const Icon(Icons.notifications),
                      title: Text(notif['message'] ?? ''),
                      subtitle: Text(
                        dateTime != null ? _formatDateTime(dateTime) : '',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Widget _buildDashboardCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required String route,
    AsyncValue<int>? count,
    required Color color,
  }) {
    return DashboardCard(
      title: title,
      subtitle: subtitle,
      icon: icon,
      onTap: () => context.go('/host/$route'),
      count: count,
      color: color,
      titleStyle: TextStyle(
        fontSize: ResponsiveUtils.getResponsiveFontSize(
          context,
          baseFontSize: ResponsiveUtils.isMobile(context) ? 14 : 16,
        ),
        fontWeight: FontWeight.w600,
      ),
      subtitleStyle: TextStyle(
        fontSize: ResponsiveUtils.getResponsiveFontSize(
          context,
          baseFontSize: ResponsiveUtils.isMobile(context) ? 12 : 14,
        ),
        color: Colors.grey[600],
      ),
    );
  }
}
