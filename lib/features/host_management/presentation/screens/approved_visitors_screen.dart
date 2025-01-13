import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../widgets/visitor_card.dart';
import '../../domain/models/visitor.dart';
import '../providers/host_providers.dart';
import 'package:go_router/go_router.dart';

class ApprovedVisitorsScreen extends HookConsumerWidget {
  const ApprovedVisitorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final approvedVisitors = ref.watch(approvedVisitorsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/host'),
        ),
        title: const Text('Approved Visitors'),
      ),
      body: approvedVisitors.when(
        data: (visitors) {
          if (visitors.isEmpty) {
            return const Center(
              child: Text('No approved visitors'),
            );
          }

          return ListView.builder(
            itemCount: visitors.length,
            itemBuilder: (context, index) {
              final visitor = visitors[index];
              return VisitorCard(
                visitor: visitor,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () => _showVisitorDetails(context, visitor),
                  ),
                ],
              );
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
      ),
    );
  }

  void _showVisitorDetails(BuildContext context, Visitor visitor) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(visitor.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${visitor.email}'),
            Text('Contact: ${visitor.contactNumber}'),
            Text('Purpose: ${visitor.purposeOfVisit}'),
            Text('Department: ${visitor.department}'),
            if (visitor.entryTime != null)
              Text('Entry Time: ${visitor.entryTime!.toLocal()}'),
            if (visitor.exitTime != null)
              Text('Exit Time: ${visitor.exitTime!.toLocal()}'),
          ],
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
} 