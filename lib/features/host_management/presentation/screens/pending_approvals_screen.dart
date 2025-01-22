import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/host_providers.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/visitor_card.dart';
import '../../domain/models/visitor.dart';

class PendingApprovalsScreen extends HookConsumerWidget {
  const PendingApprovalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingApprovalsAsync = ref.watch(pendingApprovalsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Approvals'),
      ),
      body: pendingApprovalsAsync.when(
        data: (approvals) {
          if (approvals.isEmpty) {
            return const Center(
              child: Text('No pending approvals.'),
            );
          }
          return ListView.builder(
            itemCount: approvals.length,
            itemBuilder: (context, index) {
              final visitor = approvals[index];
              return VisitorCard(
                visitor: visitor,
                onApprove: () => _handleApprove(ref, visitor),
                onReject: () => _handleReject(ref, visitor),
              );
            },
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

  Future<void> _handleApprove(WidgetRef ref, Visitor visitor) async {
    try {
      await ref.read(hostServiceProvider).approveVisitor(visitor);
    } catch (e) {
      ScaffoldMessenger.of(ref.context).showSnackBar(
        SnackBar(
          content: Text('Failed to approve visitor: $e'),
        ),
      );
    }
  }

  Future<void> _handleReject(WidgetRef ref, Visitor visitor) async {
    try {
      await ref.read(hostServiceProvider).rejectVisitor(visitor);
    } catch (e) {
      ScaffoldMessenger.of(ref.context).showSnackBar(
        SnackBar(
          content: Text('Failed to reject visitor: $e'),
        ),
      );
    }
  }
}