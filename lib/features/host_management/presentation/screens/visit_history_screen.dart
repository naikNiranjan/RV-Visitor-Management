import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../widgets/visitor_card.dart';
import '../../domain/models/visitor.dart';
import '../providers/host_providers.dart';
import 'package:go_router/go_router.dart';

class VisitHistoryScreen extends HookConsumerWidget {
  const VisitHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visitHistory = ref.watch(visitHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/host'),
        ),
        title: const Text('Visit History'),
      ),
      body: visitHistory.when(
        data: (visits) {
          if (visits.isEmpty) {
            return const Center(
              child: Text('No visit history'),
            );
          }

          return ListView.builder(
            itemCount: visits.length,
            itemBuilder: (context, index) {
              final visit = visits[index];
              return VisitorCard(
                visitor: visit,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () => _showVisitDetails(context, visit),
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

  void _showVisitDetails(BuildContext context, Visitor visit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(visit.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${visit.email}'),
            Text('Contact: ${visit.contactNumber}'),
            Text('Purpose: ${visit.purposeOfVisit}'),
            Text('Department: ${visit.department}'),
            if (visit.entryTime != null)
              Text('Entry Time: ${visit.entryTime!.toLocal()}'),
            if (visit.exitTime != null)
              Text('Exit Time: ${visit.exitTime!.toLocal()}'),
            Text('Status: ${visit.status}'),
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