import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../widgets/visitor_card.dart';
import '../../domain/models/visitor.dart';
import '../providers/host_providers.dart';
import '../../data/services/host_service.dart';
import 'package:go_router/go_router.dart';

class PendingApprovalsScreen extends HookConsumerWidget {
  const PendingApprovalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pendingApprovals = ref.watch(pendingApprovalsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/host'),
        ),
        title: const Text('Pending Approvals'),
      ),
      body: pendingApprovals.when(
        data: (visitors) {
          if (visitors.isEmpty) {
            return const Center(
              child: Text('No pending approvals'),
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
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () => _approveVisitor(ref, visitor),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () => _rejectVisitor(ref, visitor),
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

  Future<void> _approveVisitor(WidgetRef ref, Visitor visitor) async {
    try {
      await ref.read(hostServiceProvider).approveVisitor(visitor);
    } catch (e) {
      print('Error approving visitor: $e');
    }
  }

  Future<void> _rejectVisitor(WidgetRef ref, Visitor visitor) async {
    try {
      await ref.read(hostServiceProvider).rejectVisitor(visitor);
    } catch (e) {
      print('Error rejecting visitor: $e');
    }
  }
} 