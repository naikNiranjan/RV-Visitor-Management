import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/base_screen.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/firebase_provider.dart';
import 'package:intl/intl.dart';
import '../../domain/models/department_data.dart';

// Filter State
@immutable
class VisitorFilterState {
  final String? department;
  final String? status;
  final DateTime? selectedDate;
  final String? searchQuery;
  final String sortBy;
  final bool sortAscending;
  final String? visitType;

  const VisitorFilterState({
    this.department,
    this.status,
    this.selectedDate,
    this.searchQuery,
    this.sortBy = 'entryTime',
    this.sortAscending = false,
    this.visitType,
  });

  VisitorFilterState copyWith({
    String? department,
    String? status,
    DateTime? selectedDate,
    String? searchQuery,
    String? sortBy,
    bool? sortAscending,
    String? visitType,
  }) {
    return VisitorFilterState(
      department: department ?? this.department,
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      searchQuery: searchQuery ?? this.searchQuery,
      sortBy: sortBy ?? this.sortBy,
      sortAscending: sortAscending ?? this.sortAscending,
      visitType: visitType ?? this.visitType,
    );
  }
}

class VisitorFilterNotifier extends StateNotifier<VisitorFilterState> {
  VisitorFilterNotifier() : super(const VisitorFilterState());

  void updateDepartment(String? department) {
    state = state.copyWith(department: department);
  }

  void updateStatus(String? status) {
    state = state.copyWith(status: status);
  }

  void updateDate(DateTime? date) {
    state = state.copyWith(selectedDate: date);
  }

  void updateSearch(String? query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateSort(String sortBy, bool ascending) {
    state = state.copyWith(sortBy: sortBy, sortAscending: ascending);
  }

  void updateVisitType(String? type) {
    state = state.copyWith(visitType: type);
  }

  void clearFilters() {
    state = const VisitorFilterState();
  }
}

final visitorFilterProvider = StateNotifierProvider<VisitorFilterNotifier, VisitorFilterState>((ref) {
  return VisitorFilterNotifier();
});

class VisitorLogScreen extends ConsumerStatefulWidget {
  const VisitorLogScreen({super.key});

  @override
  ConsumerState<VisitorLogScreen> createState() => _VisitorLogScreenState();
}

class _VisitorLogScreenState extends ConsumerState<VisitorLogScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool _hasActiveFilters(VisitorFilterState state) {
    return state.department != null || 
           state.status != null || 
           state.visitType != null || 
           state.selectedDate != null ||
           state.searchQuery?.isNotEmpty == true;
  }

  Widget _buildActiveFilterChips(VisitorFilterState state) {
    final List<Widget> chips = [];
    
    if (state.department != null) {
      final dept = departments.firstWhere(
        (d) => d.value == state.department,
        orElse: () => Department(label: state.department!, value: state.department!),
      );
      chips.add(_buildFilterChip(
        'Department: ${dept.label}',
        () => ref.read(visitorFilterProvider.notifier).updateDepartment(null),
      ));
    }
    
    if (state.status != null) {
      chips.add(_buildFilterChip(
        'Status: ${state.status}',
        () => ref.read(visitorFilterProvider.notifier).updateStatus(null),
      ));
    }
    
    if (state.visitType != null) {
      chips.add(_buildFilterChip(
        'Type: ${state.visitType}',
        () => ref.read(visitorFilterProvider.notifier).updateVisitType(null),
      ));
    }
    
    if (state.selectedDate != null) {
      chips.add(_buildFilterChip(
        'Date: ${DateFormat('MMM dd, yyyy').format(state.selectedDate!)}',
        () => ref.read(visitorFilterProvider.notifier).updateDate(null),
      ));
    }
    
    if (state.searchQuery?.isNotEmpty == true) {
      chips.add(_buildFilterChip(
        'Search: ${state.searchQuery}',
        () => ref.read(visitorFilterProvider.notifier).updateSearch(null),
      ));
    }

    if (chips.isNotEmpty) {
      chips.add(
        TextButton.icon(
          onPressed: () => ref.read(visitorFilterProvider.notifier).clearFilters(),
          icon: const Icon(Icons.clear_all),
          label: const Text('Clear All'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: chips,
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onDeleted) {
    return Chip(
      label: Text(
        label,
        style: const TextStyle(fontSize: 13),
      ),
      deleteIcon: const Icon(Icons.close, size: 18),
      onDeleted: onDeleted,
      backgroundColor: Colors.blue.withOpacity(0.1),
      deleteIconColor: Colors.blue,
      labelStyle: const TextStyle(color: Colors.blue),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.blue.withOpacity(0.2)),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 8),
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Filter content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    MediaQuery.of(context).viewInsets.bottom + 16,
                  ),
                  child: Consumer(
                    builder: (context, ref, _) {
                      final currentState = ref.watch(visitorFilterProvider);
                      final notifier = ref.read(visitorFilterProvider.notifier);

                      return ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width - 32,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Filter Visitors',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (_hasActiveFilters(currentState))
                                  TextButton(
                                    onPressed: () {
                                      notifier.clearFilters();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Clear All'),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            
                            // Department Filter
                            _buildFilterSection(
                              'Department',
                              DropdownButtonFormField<String>(
                                isExpanded: true,
                                value: currentState.department,
                                decoration: const InputDecoration(
                                  hintText: 'Select Department',
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                ),
                                items: [
                                  const DropdownMenuItem(
                                    value: null,
                                    child: Text(
                                      'All Departments',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  ...departments.map((dept) => DropdownMenuItem(
                                    value: dept.value,
                                    child: Text(
                                      dept.label,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )),
                                ],
                                onChanged: (value) => notifier.updateDepartment(value),
                              ),
                            ),

                            // Status Filter
                            _buildFilterSection(
                              'Status',
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                alignment: WrapAlignment.start,
                                children: [
                                  _buildChoiceChip(
                                    'All',
                                    currentState.status == null,
                                    (selected) => notifier.updateStatus(null),
                                  ),
                                  _buildChoiceChip(
                                    'Pending',
                                    currentState.status?.toLowerCase() == 'pending',
                                    (selected) => notifier.updateStatus(selected ? 'pending' : null),
                                  ),
                                  _buildChoiceChip(
                                    'Checked In',
                                    currentState.status?.toLowerCase() == 'checked_in',
                                    (selected) => notifier.updateStatus(selected ? 'checked_in' : null),
                                  ),
                                  _buildChoiceChip(
                                    'Checked Out',
                                    currentState.status?.toLowerCase() == 'checked_out',
                                    (selected) => notifier.updateStatus(selected ? 'checked_out' : null),
                                  ),
                                ],
                              ),
                            ),

                            // Visit Type Filter
                            _buildFilterSection(
                              'Visit Type',
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                alignment: WrapAlignment.start,
                                children: [
                                  _buildChoiceChip(
                                    'All',
                                    currentState.visitType == null,
                                    (selected) => notifier.updateVisitType(null),
                                  ),
                                  _buildChoiceChip(
                                    'Registration',
                                    currentState.visitType?.toLowerCase() == 'registration',
                                    (selected) => notifier.updateVisitType(selected ? 'registration' : null),
                                  ),
                                  _buildChoiceChip(
                                    'Quick Check-in',
                                    currentState.visitType?.toLowerCase() == 'quick_checkin',
                                    (selected) => notifier.updateVisitType(selected ? 'quick_checkin' : null),
                                  ),
                                  _buildChoiceChip(
                                    'Cab',
                                    currentState.visitType?.toLowerCase() == 'cab',
                                    (selected) => notifier.updateVisitType(selected ? 'cab' : null),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                              ),
                              child: const Text('Apply Filters'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: content,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildChoiceChip(String label, bool selected, Function(bool) onSelected) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      selectedColor: Colors.blue.withOpacity(0.2),
      labelStyle: TextStyle(
        color: selected ? Colors.blue : Colors.black87,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filterState = ref.watch(visitorFilterProvider);
    
    return BaseScreen(
      title: 'Visitor Log',
      useCustomAppBar: true,
      body: Column(
        children: [
          // Search and Filter Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search visitors...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (value) => ref.read(visitorFilterProvider.notifier).updateSearch(value),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: _showFilterDialog,
                ),
                IconButton(
                  icon: Icon(filterState.sortAscending ? Icons.arrow_upward : Icons.arrow_downward),
                  onPressed: () => ref.read(visitorFilterProvider.notifier)
                      .updateSort(filterState.sortBy, !filterState.sortAscending),
                ),
              ],
            ),
          ),

          // Active Filters
          if (_hasActiveFilters(filterState))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: _buildActiveFilterChips(filterState),
            ),

          // Visitor List
          Expanded(
            child: StreamBuilder(
              stream: ref.read(firebaseServiceProvider).getVisitorLogs(
                department: filterState.department,
                status: filterState.status,
                selectedDate: filterState.selectedDate,
                searchQuery: filterState.searchQuery,
                sortBy: 'createdAt',
                ascending: filterState.sortAscending,
                visitType: filterState.visitType,
              ),
              builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  print('Error in VisitorLogScreen: ${snapshot.error}');
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          'Error: ${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            ref.invalidate(visitorFilterProvider);
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                final logs = snapshot.data ?? [];
                
                if (logs.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'No visitors found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: logs.length,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) => _buildVisitorCard(context, ref, logs[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return 'N/A';
    
    try {
      if (timestamp is String) {
        return DateFormat('MMM dd, yyyy hh:mm a').format(DateTime.parse(timestamp));
      } else if (timestamp is DateTime) {
        return DateFormat('MMM dd, yyyy hh:mm a').format(timestamp);
      }
      return 'N/A';
    } catch (e) {
      print('Error formatting timestamp: $e');
      return 'N/A';
    }
  }

  String _formatExitTime(dynamic timestamp) {
    if (timestamp == null) return 'Not exited';
    
    try {
      if (timestamp is String) {
        return DateFormat('hh:mm a').format(DateTime.parse(timestamp));
      } else if (timestamp is DateTime) {
        return DateFormat('hh:mm a').format(timestamp);
      }
      return 'Not exited';
    } catch (e) {
      print('Error formatting exit time: $e');
      return 'Not exited';
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

  Future<void> _handleCheckout(BuildContext context, WidgetRef ref, Map<String, dynamic> log) async {
    try {
      // Show confirmation dialog
      final bool? confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirm Checkout'),
          content: Text('Do you want to check out ${log['name']}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Checkout'),
            ),
          ],
        ),
      );

      if (confirm == true) {
        // Show loading indicator
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Processing checkout...'),
            duration: Duration(seconds: 1),
          ),
        );

        // Perform checkout
        await ref.read(firebaseServiceProvider).checkoutVisitor(log['visitId']);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Visitor checked out successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error checking out: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildVisitorCard(BuildContext context, WidgetRef ref, Map<String, dynamic> log) {
    final entryTime = _formatTimestamp(log['entryTime']);
    final status = log['status'] ?? 'pending';
    final statusColor = Color(
      int.parse(_getStatusColor(status).replaceAll('#', '0xFF'))
    );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _showVisitorDetails(context, log),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
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
                      if (status != 'checked_out')
                        TextButton(
                          onPressed: () => _handleCheckout(context, ref, log),
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.primaryColor,
                          ),
                          child: const Text('Check Out'),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
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
                      _buildDetailRow('Has Photo', log['hasPhoto'] == true ? 'Yes' : 'No'),
                      _buildDetailRow('Has Document', log['hasDocument'] == true ? 'Yes' : 'No'),
                      _buildDetailRow('Visit Count', '${log['visitCount'] ?? 1}'),
                      _buildDetailRow('Created At', _formatTimestamp(log['createdAt'])),
                      _buildDetailRow('Updated At', _formatTimestamp(log['updatedAt'])),
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
}
