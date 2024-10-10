import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seneso_admin/models/user.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  String selectedRole = 'Agriculteur'; // Rôle par défaut

  void signup() async {
    setState(() {
      isLoading = true;
    });
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Créer un nouvel utilisateur
      Utilisateur nouvelUtilisateur = Utilisateur(
        id: userCredential.user!.uid,
        nom: nameController.text,
        prenom: prenomController.text,
        email: emailController.text,
        motDePasse: passwordController.text,
        role: selectedRole, // Utilise le rôle sélectionné
      );

      // Ajouter les données spécifiques dans Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(nouvelUtilisateur.id)
          .set({
        'nom': nouvelUtilisateur.nom,
        'prenom': nouvelUtilisateur.prenom,
        'email': nouvelUtilisateur.email,
        'motDePasse': nouvelUtilisateur.motDePasse,
        'role': nouvelUtilisateur.role,
      });

      // Afficher un message de succès
      _showSnackbar("Inscription réussie !");

      // Rediriger l'utilisateur après inscription
      Navigator.pushNamed(context, '/LoginScreen');
    } catch (e) {
      // Afficher un message d'erreur
      _showSnackbar("Erreur lors de l'inscription : $e");
    }
    setState(() {
      isLoading = false;
    });
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inscription Utilisateur"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildTextField(
                  controller: nameController,
                  hintText: 'Nom',
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: prenomController,
                  hintText: 'Prénom',
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: emailController,
                  hintText: 'Email',
                  icon: Icons.email,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: passwordController,
                  hintText: 'Mot de passe',
                  icon: Icons.lock,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                // Champ de sélection pour le rôle
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  decoration: InputDecoration(
                    hintText: 'Sélectionnez un rôle',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: <String>['Agriculteur', 'Administrateur', 'Partenaire']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRole = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 40),
                isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: signup,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: Colors.green,
                        ),
                        child: const Text(
                          'S\'inscrire',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
