import 'package:flutter/material.dart';
import '../../../../core/widgets/base_screen.dart';

class VisitorLogScreen extends StatelessWidget {
  const VisitorLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Visitor Log',
      useCustomAppBar: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text('Visitor ${index + 1}'),
                subtitle: Text(
                    'Entry Time: ${DateTime.now().toString().substring(0, 16)}'),
                trailing: const Icon(Icons.chevron_right),
              ),
            );
          },
        ),
      ),
    );
  }
}
