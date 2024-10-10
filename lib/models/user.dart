import 'package:cloud_firestore/cloud_firestore.dart';

class Utilisateur {
  String id;
  String nom;
  String prenom;
  String email;
  String motDePasse; // Champ pour le mot de passe
  String role;

  Utilisateur({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.motDePasse,
    required this.role,
  });

  // Méthode pour créer un utilisateur depuis un document Firestore
  factory Utilisateur.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Utilisateur(
      id: doc.id,
      nom: data['nom'],
      prenom: data['prenom'],
      email: data['email'],
      motDePasse: data['motDePasse'], // Ajout du mot de passe
      role: data['role'] ?? 'utilisateur', // Valeur par défaut si 'role' est null
    );
  }

  // Méthode pour convertir un utilisateur en format Map (pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'motDePasse': motDePasse, // Ajout du mot de passe
      'role': role,
    };
  }
}
