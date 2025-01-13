import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import "../../../auth/data/services/auth_service.dart";

class ProfileScreen extends HookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).value; // Fetch user data
    final userDataAsyncValue = ref.watch(userDataProvider(user?.uid));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        foregroundColor: AppTheme.primaryColor,
        elevation: 0,
      ),
      body: user == null // Check if user data is available
          ? const Center(child: CircularProgressIndicator())
          : userDataAsyncValue.when(
              data: (userData) => SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(user.photoURL ?? ''), // Display profile photo
                            child: user.photoURL == null
                                ? const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            user.displayName ?? 'User Name', // Display user name
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Role: ${userData?['role'] ?? 'Not Set'}', // Placeholder for role
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildProfileItem(
                            icon: Icons.badge_outlined,
                            title: 'Staff ID',
                            content: userData?['staffId'] ?? 'Not Set', // Placeholder for staff ID
                          ),
                          _buildProfileItem(
                            icon: Icons.phone_outlined,
                            title: 'Contact',
                            content: userData?['contactNumber'] ?? 'Not Set', // Placeholder for contact number
                          ),
                          _buildProfileItem(
                            icon: Icons.email_outlined,
                            title: 'Email',
                            content: user.email ?? 'N/A', // Display email
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Add change password functionality
                                _changePassword(context, ref);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryColor,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('Change Password'),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                await ref.read(authProvider.notifier).signOut(); // Logout
                                Navigator.of(context).pop(); // Navigate back to login
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryColor,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text('Logout'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
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

  Future<void> _changePassword(BuildContext context, WidgetRef ref) async {
    // Implement change password functionality here
    // You can use a dialog to get the new password from the user
  }
}

// Define a provider to fetch user data
final userDataProvider = FutureProvider.family<Map<String, dynamic>?, String?>((ref, uid) async {
  if (uid == null) return null;
  return await ref.read(authProvider.notifier).fetchUserData(uid);
});
