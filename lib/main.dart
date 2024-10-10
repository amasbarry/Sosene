import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:seneso_admin/views/Administrationscreen.dart';
import 'package:seneso_admin/views/Dashboard.dart';

import 'package:seneso_admin/views/Loginpage.dart';
// Page de connexion

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser Firebase avec gestion des erreurs
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBlornv4Vjw3yHcvXBDpgFNvEyEsMRNc94',
        appId: '1:253781086260:web:a97d9f225576e33cbefa61',
        messagingSenderId: '253781086260',
        projectId: 'sosenebrry',
        authDomain: 'sosenebrry.firebaseapp.com',
        storageBucket: 'sosenebrry.appspot.com',
        measurementId: 'G-DWHVYJ2HS7',
      ),
    );
  } catch (e) {
    print("Erreur lors de l'initialisation de Firebase: $e");
  }

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sosenebrry Admin', // Titre de l'application admin
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Route initiale vers la page de connexion
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(), // Page d'accueil Loginpage
        // '/LoginScreen': (context) => LoginScreen(), // Page de tableau de bord
      },
    );
  }
}
