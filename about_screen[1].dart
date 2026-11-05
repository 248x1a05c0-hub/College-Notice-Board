import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Campus Connect')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 42,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Icon(
              Icons.campaign,
              size: 46,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Campus Connect',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          const Text(
            'A simple college notice board application that helps students '
            'view and organize campus announcements.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          const Card(
            child: ListTile(
              leading: Icon(Icons.school_outlined),
              title: Text('Institution'),
              subtitle: Text('KHIT – update with your college details'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.code),
              title: Text('Built with'),
              subtitle: Text('Flutter, Dart, Provider and SharedPreferences'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Version'),
              subtitle: Text('1.0.0'),
            ),
          ),
        ],
      ),
    );
  }
}
