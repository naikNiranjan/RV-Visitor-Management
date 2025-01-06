import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/animated_list_item.dart';

class ApprovalStatusScreen extends StatelessWidget {
  const ApprovalStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10, // Replace with actual data count
        itemBuilder: (context, index) {
          return AnimatedListItem(
            index: index,
            title: 'Visitor ${index + 1}',
            subtitle: 'Pending Approval',
            leadingIcon: Icons.pending_actions,
            onTap: () {
              // Handle tap
            },
          );
        },
      ),
    );
  }
}
