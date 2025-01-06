import 'package:flutter/material.dart';

class VisitorLogPage extends StatelessWidget {
  const VisitorLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visitor Log'),
      ),
      body: const Center(
        child: Text('Visitor Log Page Content'),
      ),
    );
  }
}
