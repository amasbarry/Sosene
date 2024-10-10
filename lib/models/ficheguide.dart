import 'package:cloud_firestore/cloud_firestore.dart';


class FicheGuide {
  String id;  // Identifiant unique du guide
  String titre;  // Titre du guide
  String contenu;  // Contenu du guide
  String auteur;  // Auteur du guide
  DateTime datePublication;  // Date de publication du guide
  String image;  // URL de l'image du guide

  FicheGuide({
    required this.id,
    required this.titre,
    required this.contenu,
    required this.auteur,
    required this.datePublication,
    required this.image,
  });

  // Méthode pour convertir un guide depuis un document Firestore
  factory FicheGuide.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return FicheGuide(
      id: doc.id,
      titre: data['titre'],
      contenu: data['contenu'],
      auteur: data['auteur'],
      datePublication: (data['datePublication'] as Timestamp).toDate(),
      image: data['image'] ?? '',
    );
  }

  // Méthode pour convertir un guide en format Map (pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'titre': titre,
      'contenu': contenu,
      'auteur': auteur,
      'datePublication': datePublication,
      'image': image,
    };
  }
}
