import 'package:flutter/material.dart';
import 'package:seneso_admin/views/Administrationscreen.dart';
import 'package:seneso_admin/views/AgricultureCalendarView.dart';
import 'package:seneso_admin/models/partenaire_model.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Admin',
      theme: ThemeData(
        primaryColor: const Color(0xFF4CAF50),
        hintColor: const Color(0xFF8BC34A),
        brightness: Brightness.light,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
        ),
        cardColor: const Color(0xFFF1F8E9),
      ),
      home: const AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Drawer étendu sur toute la hauteur
          SizedBox(
            width: MediaQuery.of(context).size.width > 600 ? 250 : 200,
            height: MediaQuery.of(context).size.height,
            child: Drawer(
              elevation: 0,
              child: Column(
                children: <Widget>[
                  DrawerHeader(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: Image.asset(
                            'assets/images/logoseneso.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                       
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        buildMenuItem(
                          icon: Icons.dashboard,
                          title: 'Tableau de Bord',
                          index: 0,
                        ),
                        buildMenuItem(
                          icon: Icons.person,
                          title: 'Gestion des Utilisateurs',
                          index: 1,
                        ),
                        buildMenuItem(
                          icon: Icons.library_books,
                          title: 'Fiches Techniques',
                          index: 2,
                        ),
                        buildMenuItem(
                          icon: Icons.video_library,
                          title: 'Bibliothèque Vidéos',
                          index: 3,
                        ),
                        buildMenuItem(
                          icon: Icons.calendar_today,
                          title: 'Calendrier Agricole',
                          index: 4,
                        ),
                        buildMenuItem(
                          icon: Icons.business,
                          title: 'Gestion des Partenaires',
                          index: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Contenu principal
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                const DashboardBody(),
                AdministrateurListScreen(),
                const FicheTechniqueView(),
                const VideoLibraryView(),
                const AgriculturalCalendarView(), 
                const PartnersManagementView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF4CAF50)),
      title: Text(title, style: const TextStyle(color: Colors.black87)),
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      hoverColor: const Color(0xFFE8F5E9),
    );
  }
}

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Statistiques',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
              childAspectRatio: 3 / 1,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: const [
                _StatCard(title: 'Utilisateurs', value: '150'),
                _StatCard(title: 'Cultures', value: '120'),
                _StatCard(title: 'Notifications', value: '50'),
                _StatCard(title: 'Partenaires', value: '30'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

// Classes pour les différentes vues
class UsersManagement extends StatelessWidget {
  const UsersManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Gestion des Utilisateurs'));
  }
}

class FicheTechniqueView extends StatelessWidget {
  const FicheTechniqueView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Fiches Techniques'));
  }
}

class VideoLibraryView extends StatelessWidget {
  const VideoLibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Bibliothèque Vidéos'));
  }
}

class PartnersManagementView extends StatelessWidget {
  const PartnersManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Gestion des Partenaires'));
  }
}
