import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/firebase_provider.dart';
import 'package:intl/intl.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final sortAscendingProvider = StateProvider<bool>((ref) => false);

class TodaysVisitorsScreen extends ConsumerWidget {
  const TodaysVisitorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final isAscending = ref.watch(sortAscendingProvider);

    return BaseScreen(
      title: "Today's Visitors",
      useCustomAppBar: true,
      actions: [
        IconButton(
          icon: Icon(isAscending ? Icons.arrow_upward : Icons.arrow_downward),
          onPressed: () => ref.read(sortAscendingProvider.notifier).state = !isAscending,
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context, ref),
        ),
      ],
      body: Column(
        children: [
          // Date and Count Display
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('MMMM dd, yyyy').format(selectedDate),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                StreamBuilder(
                  stream: ref.read(firebaseServiceProvider).getVisitorLogs(
                    selectedDate: selectedDate,
                  ),
                  builder: (context, snapshot) {
                    final visitorCount = snapshot.data?.length ?? 0;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.people,
                                size: 16,
                                color: AppTheme.primaryColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '$visitorCount ${visitorCount == 1 ? 'Visitor' : 'Visitors'}',
                                style: TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          // Visitors List
          Expanded(
            child: StreamBuilder(
              stream: ref.read(firebaseServiceProvider).getVisitorLogs(
                selectedDate: selectedDate,
                sortBy: 'createdAt',
                ascending: isAscending,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                final logs = snapshot.data ?? [];
                if (logs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No visitors on ${DateFormat('MMM dd').format(selectedDate)}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Sort logs by time if needed
                final sortedLogs = List<Map<String, dynamic>>.from(logs);
                sortedLogs.sort((a, b) {
                  final aTime = DateTime.parse(a['createdAt']);
                  final bTime = DateTime.parse(b['createdAt']);
                  return isAscending ? aTime.compareTo(bTime) : bTime.compareTo(aTime);
                });

                return ListView.builder(
                  itemCount: sortedLogs.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) => _buildVisitorCard(
                    context,
                    sortedLogs[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, WidgetRef ref) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: ref.read(selectedDateProvider),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      ref.read(selectedDateProvider.notifier).state = picked;
    }
  }

  Widget _buildVisitorCard(BuildContext context, Map<String, dynamic> log) {
    final entryTime = _formatTimestamp(log['entryTime']);
    final status = log['status'] ?? 'pending';
    final statusColor = Color(
      int.parse(_getStatusColor(status).replaceAll('#', '0xFF'))
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _showVisitorDetails(context, log),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                    child: Icon(
                      _getVisitorIcon(log['type']),
                      color: AppTheme.primaryColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          log['name'] ?? 'Unknown',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Entry: $entryTime',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status.toUpperCase(),
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildInfoRow('Department', log['department'] ?? 'N/A'),
              _buildInfoRow('Host', log['whomToMeet'] ?? 'N/A'),
              _buildInfoRow('Purpose', log['purposeOfVisit'] ?? 'N/A'),
            ],
          ),
        ),
      ),
    );
  }

  void _showVisitorDetails(BuildContext context, Map<String, dynamic> log) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: controller,
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildDetailSection('Visit Details', [
                      _buildDetailRow('Name', log['name'] ?? 'N/A'),
                      _buildDetailRow('Phone', log['contactNumber'] ?? 'N/A'),
                      _buildDetailRow('Email', log['email'] ?? 'N/A'),
                      _buildDetailRow('Purpose', log['purposeOfVisit'] ?? 'N/A'),
                      _buildDetailRow('Host', log['whomToMeet'] ?? 'N/A'),
                      _buildDetailRow('Department', log['department'] ?? 'N/A'),
                      _buildDetailRow('Visitors', '${log['numberOfVisitors'] ?? 1}'),
                      _buildDetailRow('Visit Type', log['type']?.toString().toUpperCase() ?? 'N/A'),
                      _buildDetailRow('Status', log['status']?.toString().toUpperCase() ?? 'N/A'),
                    ]),
                    if (log['type'] == 'cab')
                      _buildDetailSection('Cab Details', [
                        _buildDetailRow('Vehicle', log['vehicleNumber'] ?? 'N/A'),
                        _buildDetailRow('Driver', log['driverName'] ?? 'N/A'),
                        _buildDetailRow('Driver Contact', log['driverContact'] ?? 'N/A'),
                        _buildDetailRow('Cab Provider', log['cabProvider'] ?? 'N/A'),
                      ]),
                    _buildDetailSection('Additional Information', [
                      _buildDetailRow('Document Type', log['documentType'] ?? 'N/A'),
                      _buildDetailRow('Entry Time', _formatTimestamp(log['entryTime'])),
                      _buildDetailRow('Exit Time', _formatTimestamp(log['exitTime'])),
                      if (log['remarks'] != null)
                        _buildDetailRow('Remarks', log['remarks']),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getVisitorIcon(String? type) {
    switch (type) {
      case 'cab':
        return Icons.local_taxi;
      case 'quick_checkin':
        return Icons.quick_contacts_dialer;
      default:
        return Icons.person;
    }
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return 'N/A';
    
    try {
      if (timestamp is String) {
        return DateFormat('hh:mm a').format(DateTime.parse(timestamp));
      } else if (timestamp is DateTime) {
        return DateFormat('hh:mm a').format(timestamp);
      }
      return 'N/A';
    } catch (e) {
      print('Error formatting timestamp: $e');
      return 'N/A';
    }
  }

  String _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'checked_in':
        return '#4CAF50'; // Green
      case 'checked_out':
        return '#FF5722'; // Orange
      case 'pending':
        return '#FFC107'; // Yellow
      default:
        return '#9E9E9E'; // Grey
    }
  }
}
