import 'package:flutter/material.dart';

class AgriculteurDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agriculteur Dashboard'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          'Bienvenue sur le Dashboard Agriculteur',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
