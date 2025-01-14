import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/host_providers.dart';
import '../../../../core/theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class VisitHistoryScreen extends HookConsumerWidget {
  const VisitHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentHost = ref.watch(currentHostProvider);
    final visitHistory = ref.watch(hostVisitorHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/host'),
        ),
        title: const Text('Visit History'),
      ),
      body: currentHost.when(
        data: (host) {
          if (host == null) {
            return const Center(child: Text('Host data not found'));
          }

          return visitHistory.when(
            data: (visits) {
              if (visits.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.history,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No visit history',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: visits.length,
                itemBuilder: (context, index) {
                  final visit = visits[index];
                  return _buildVisitCard(context, visit);
                },
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
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }

  Widget _buildVisitCard(BuildContext context, Map<String, dynamic> visit) {
    final visitTime = visit['visitTime'] as DateTime?;
    final formattedDate = visitTime != null
        ? DateFormat('MMM dd, yyyy • hh:mm a').format(visitTime)
        : 'N/A';
    final name = visit['name'] as String? ?? 'Unknown';
    final contactNumber = visit['contactNumber'] as String? ?? 'N/A';
    final purpose = visit['purposeOfVisit'] as String? ?? 'N/A';
    final type = visit['type'] as String? ?? 'unknown';
    final status = visit['status'] as String? ?? 'unknown';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: InkWell(
        onTap: () => _showVisitDetails(context, visit),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                    child: Icon(
                      _getVisitTypeIcon(type),
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusChip(status),
                ],
              ),
              if (contactNumber != 'N/A' || purpose != 'N/A') ...[
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                _buildInfoRow(
                  Icons.phone_outlined,
                  contactNumber,
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  Icons.assignment_outlined,
                  purpose,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  IconData _getVisitTypeIcon(String? type) {
    switch (type?.toLowerCase()) {
      case 'quick_checkin':
        return Icons.flash_on;
      case 'cab':
        return Icons.local_taxi;
      case 'registration':
        return Icons.how_to_reg;
      default:
        return Icons.person_outline;
    }
  }

  Widget _buildStatusChip(String? status) {
    Color color;
    String label;

    switch (status?.toLowerCase()) {
      case 'checked_in':
        color = Colors.green;
        label = 'Checked In';
        break;
      case 'checked_out':
        color = Colors.grey;
        label = 'Checked Out';
        break;
      case 'pending':
        color = Colors.orange;
        label = 'Pending';
        break;
      default:
        color = Colors.grey;
        label = 'Unknown';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  void _showVisitDetails(BuildContext context, Map<String, dynamic> visit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(visit['name'] as String? ?? 'Visit Details'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Contact', visit['contactNumber']),
              _buildDetailRow('Email', visit['email']),
              _buildDetailRow('Purpose', visit['purposeOfVisit']),
              _buildDetailRow('Department', visit['department']),
              _buildDetailRow('Visit Type', visit['type']),
              _buildDetailRow('Status', visit['status']),
              if (visit['vehicleNumber'] != null)
                _buildDetailRow('Vehicle', visit['vehicleNumber']),
              if (visit['type'] == 'cab') ...[
                _buildDetailRow('Cab Provider', visit['cabProvider']),
                _buildDetailRow('Driver Name', visit['driverName']),
                _buildDetailRow('Driver Contact', visit['driverContact']),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value?.toString() ?? 'N/A',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
