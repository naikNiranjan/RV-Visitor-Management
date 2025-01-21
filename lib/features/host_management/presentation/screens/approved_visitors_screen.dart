import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/host_providers.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/visitor_card.dart';
import '../../domain/models/visitor.dart';

class ApprovedVisitorsScreen extends HookConsumerWidget {
  const ApprovedVisitorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final approvedVisitorsAsync = ref.watch(approvedVisitorsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Approved Visitors'),
      ),
      body: approvedVisitorsAsync.when(
        data: (visitors) {
          if (visitors.isEmpty) {
            return const Center(
              child: Text('No approved visitors.'),
            );
          }
          return ListView.builder(
            itemCount: visitors.length,
            itemBuilder: (context, index) {
              final visitor = visitors[index];
              return VisitorCard(
                visitor: visitor,
                onApprove: () {},
                onReject: () {},
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
}