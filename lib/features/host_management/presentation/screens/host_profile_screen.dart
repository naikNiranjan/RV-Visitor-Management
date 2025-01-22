import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/host_providers.dart';
import '../../../../core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/data/services/auth_service.dart';
import '../../domain/models/host.dart';
import '../../../visitor_management/domain/models/department_data.dart';

class HostProfileScreen extends HookConsumerWidget {
  const HostProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hostAsync = ref.watch(currentHostProvider);
    final pendingApprovalsCountAsync = ref.watch(pendingApprovalsCountProvider);
    final approvedVisitorsCountAsync = ref.watch(approvedVisitorsCountProvider);
    final visitHistoryCountAsync = ref.watch(visitHistoryCountProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/host'),
        ),
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authProvider.notifier).signOut();
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      body: hostAsync.when(
        data: (host) {
          if (host == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No host data found.'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _showEditProfileDialog(context, ref),
                    child: const Text('Add Profile Data'),
                  ),
                ],
              ),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                          image: host.profilePhotoUrl != null
                              ? DecorationImage(
                                  image: NetworkImage(host.profilePhotoUrl!),
                                  fit: BoxFit.cover,
                                  onError: (exception, stackTrace) =>
                                      const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/default_profile.png'),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/default_profile.png'),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () => _showEditProfileDialog(context, ref),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildInfoSection(
                  title: 'Personal Information',
                  items: [
                    _buildInfoItem(Icons.person, 'Name', host.name),
                    _buildInfoItem(Icons.email, 'Email', host.email),
                    _buildInfoItem(
                        Icons.phone, 'Contact', host.contactNumber),
                    _buildInfoItem(
                      Icons.business,
                      'Department',
                      departments.firstWhere(
                        (dept) => dept.value == host.department,
                        orElse: () =>
                            const Department(label: 'Unknown', value: 'UNKNOWN'),
                      ).label,
                    ),
                    _buildInfoItem(Icons.work, 'Position',
                        host.position ?? 'Not Specified'),
                  ],
                ),
                const SizedBox(height: 16),
                _buildInfoSection(
                  title: 'Statistics',
                  items: [
                    _buildInfoItem(
                      Icons.pending,
                      'Pending Approvals',
                      pendingApprovalsCountAsync.when(
                        data: (count) => count.toString(),
                        loading: () => 'Loading...',
                        error: (error, _) => 'Error',
                      ),
                    ),
                    _buildInfoItem(
                      Icons.check_circle,
                      'Approved Visitors',
                      approvedVisitorsCountAsync.when(
                        data: (count) => count.toString(),
                        loading: () => 'Loading...',
                        error: (error, _) => 'Error',
                      ),
                    ),
                    _buildInfoItem(
                      Icons.history,
                      'Total Visits',
                      visitHistoryCountAsync.when(
                        data: (count) => count.toString(),
                        loading: () => 'Loading...',
                        error: (error, _) => 'Error',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: SelectableText.rich(
            TextSpan(
              text: 'Error: ${error.toString()}',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showEditProfileDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final host = ref.read(currentHostProvider).value;
    final nameController = TextEditingController(text: host?.name ?? '');
    final contactController =
        TextEditingController(text: host?.contactNumber ?? '');
    final positionController = TextEditingController(text: host?.position ?? '');
    String? selectedDepartment = host?.department;

    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Name is required' : null,
                ),
                TextFormField(
                  controller: contactController,
                  decoration: const InputDecoration(labelText: 'Contact Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Contact is required'
                      : null,
                ),
                TextFormField(
                  controller: positionController,
                  decoration: const InputDecoration(labelText: 'Position'),
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Department'),
                  value: selectedDepartment,
                  items: departments
                      .map((dept) => DropdownMenuItem(
                            value: dept.value,
                            child: Text(dept.label),
                          ))
                      .toList(),
                  onChanged: (value) => selectedDepartment = value,
                  validator: (value) =>
                      value == null ? 'Department is required' : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                final user = ref.read(authProvider).value;
                if (user != null) {
                  final hostService = ref.read(hostServiceProvider);
                  final currentHost = ref.read(currentHostProvider).value;
                  final updatedHost = (currentHost ??
                          Host(
                            email: user.email!,
                            name: '',
                            contactNumber: '',
                            department: '',
                            role: 'host',
                            notificationSettings: {
                              'emailNotifications': true,
                              'smsNotifications': false,
                            },
                          ))
                      .copyWith(
                    name: nameController.text,
                    contactNumber: contactController.text,
                    position: positionController.text,
                    department: selectedDepartment!,
                  );
                  await _updateHostData(
                    ref,
                    updatedHost,
                  );

                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _updateHostData(WidgetRef ref, Host host) async {
    final hostService = ref.read(hostServiceProvider);
    try {
      await hostService.registerHost(
        email: host.email,
        name: host.name,
        department: host.department,
        contactNumber: host.contactNumber,
        position: host.position,
        profilePhotoUrl: host.profilePhotoUrl,
      );
      ref.invalidate(currentHostProvider);
    } catch (e) {
      print('Error updating host data: $e');
    }
  }

  Widget _buildInfoSection({
    required String title,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: items,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}