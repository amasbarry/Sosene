import 'package:flutter/material.dart';

class PartenaireDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Partenaire Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text(
          'Bienvenue sur le Dashboard Partenaire',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
