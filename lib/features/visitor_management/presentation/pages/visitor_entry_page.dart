import 'package:flutter/material.dart';

class VisitorEntryPage extends StatelessWidget {
  const VisitorEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visitor Entry'),
      ),
      body: const Center(
        child: Text('Visitor Entry Page Content'),
      ),
    );
  }
}
