import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/animated_list_item.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({super.key});

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
            title: 'Document ${index + 1}',
            subtitle: 'ID Card',
            leadingIcon: Icons.description_outlined,
            onTap: () {
              // Handle tap
            },
          );
        },
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildFloatingActionButton() {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 500),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: FloatingActionButton(
        onPressed: () {
          // Handle upload
        },
        child: const Icon(Icons.upload_file),
      ),
    );
  }
}
