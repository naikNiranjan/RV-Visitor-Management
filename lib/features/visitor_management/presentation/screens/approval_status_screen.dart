import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ApprovalStatusScreen extends StatelessWidget {
  const ApprovalStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Approval Status Screen'),
      ),
      body: const Center(
        child: Text('Approval Status Screen'),
      ),
    );
  }
}
