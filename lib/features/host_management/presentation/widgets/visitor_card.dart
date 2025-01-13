import 'package:flutter/material.dart';
import '../../domain/models/visitor.dart';

class VisitorCard extends StatelessWidget {
  final Visitor visitor;
  final VoidCallback? onTap;
  final List<Widget>? actions;

  const VisitorCard({
    super.key,
    required this.visitor,
    this.onTap,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          child: Text(visitor.name[0].toUpperCase()),
        ),
        title: Text(visitor.name),
        subtitle: Text(visitor.purposeOfVisit),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: actions ?? [],
        ),
      ),
    );
  }
} 