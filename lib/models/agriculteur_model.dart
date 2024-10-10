import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seneso_admin/models/user.dart';


class Agriculteur extends Utilisateur {
  String typeExploitation; // Amateur ou Professionnel
  List<String> culturesSuivies; // Liste des cultures principales
  String region; // Région de l'agriculteur

  Agriculteur({
    required super.id,
    required super.nom,
    required super.prenom,
    required super.email,
    required super.motDePasse, // Mot de passe
    required super.role, // "agriculteur"
    required this.typeExploitation,
    required this.culturesSuivies,
    required this.region,
  });

  factory Agriculteur.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Agriculteur(
      id: doc.id,
      nom: data['nom'],
      prenom: data['prenom'],
      email: data['email'],
      motDePasse: data['motDePasse'], // Ajout du mot de passe
      role: data['role'],
      typeExploitation: data['typeExploitation'] ?? '',
      culturesSuivies: List<String>.from(data['culturesSuivies'] ?? []),
      region: data['region'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'typeExploitation': typeExploitation,
      'culturesSuivies': culturesSuivies,
      'region': region,
    });
    return map;
  }
}