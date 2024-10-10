import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seneso_admin/models/user.dart';

class Partenaire extends Utilisateur {
  String entreprise;
  String secteur;
  String type;

  Partenaire({
    required String id,
    required String nom,
    required String prenom,
    required String email,
    required String motDePasse,
    required String role,
    required this.entreprise,
    required this.secteur,
    required this.type,
  }) : super(id: id, nom: nom, prenom: prenom, email: email, motDePasse: motDePasse, role: role);

  factory Partenaire.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Partenaire(
      id: doc.id,
      nom: data['nom'],
      prenom: data['prenom'],
      email: data['email'],
      motDePasse: data['motDePasse'],
      role: data['role'],
      entreprise: data['entreprise'] ?? '',
      secteur: data['secteur'] ?? '',
      type: data['type'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'entreprise': entreprise,
      'secteur': secteur,
      'type': type,
    });
    return map;
  }
}
