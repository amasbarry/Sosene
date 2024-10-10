import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seneso_admin/models/agriculteur_model.dart';

class Reponse {
  String id; // Identifiant unique de la réponse
  String contenu; // Contenu de la réponse
  Agriculteur agriculteur; // L'agriculteur qui a répondu
  DateTime createdAt; // Date de création de la réponse
  String postId; // ID du post auquel cette réponse appartient

  Reponse({
    required this.id,
    required this.contenu,
    required this.agriculteur,
    required this.createdAt,
    required this.postId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contenu': contenu,
      'agriculteur': agriculteur.toMap(),
      'createdAt': createdAt.toIso8601String(),
      'postId': postId,
    };
  }

  static Reponse fromJson(Map<String, dynamic> json) {
    return Reponse(
      id: json['id'],
      contenu: json['contenu'],
      agriculteur: Agriculteur(
        id: json['agriculteur']['id'],
        nom: json['agriculteur']['nom'],
        prenom: json['agriculteur']['prenom'],
        email: json['agriculteur']['email'],
        motDePasse: json['agriculteur']['motDePasse'], // Assurez-vous que cela est correct
        role: json['agriculteur']['role'],
        typeExploitation: json['agriculteur']['typeExploitation'] ?? '',
        culturesSuivies: List<String>.from(json['agriculteur']['culturesSuivies'] ?? []),
        region: json['agriculteur']['region'] ?? '',
      ),
      createdAt: DateTime.parse(json['createdAt']),
      postId: json['postId'],
    );
  }

  Future<void> saveReponseToFirestore() async {
    final docRef = FirebaseFirestore.instance.collection('reponses').doc(id);
    await docRef.set(toJson());
  }

  static Future<Reponse> loadReponseFromFirestore(String reponseId) async {
    final doc = await FirebaseFirestore.instance.collection('reponses').doc(reponseId).get();
    if (doc.exists) {
      return Reponse.fromJson(doc.data()!);
    } else {
      throw Exception('Réponse non trouvée');
    }
  }
}