import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seneso_admin/models/user.dart';

class Administrateur extends Utilisateur {
  String privileges;

  Administrateur({
    required String id,
    required String nom,
    required String prenom,
    required String email,
    required String motDePasse,
    required String role,
    required this.privileges,
  }) : super(id: id, nom: nom, prenom: prenom, email: email, motDePasse: motDePasse, role: role);

  factory Administrateur.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Administrateur(
      id: doc.id,
      nom: data['nom'],
      prenom: data['prenom'],
      email: data['email'],
      motDePasse: data['motDePasse'],
      role: data['role'],
      privileges: data['privileges'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({
      'privileges': privileges,
    });
    return map;
  }
}
