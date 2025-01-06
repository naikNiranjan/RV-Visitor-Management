import 'package:flutter/material.dart';

class TodaysVisitorsScreen extends StatelessWidget {
  const TodaysVisitorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Today's Visitors"),
      ),
      body: const Center(
        child: Text('Today\'s Visitors Screen Content'),
      ),
    );
  }
}
