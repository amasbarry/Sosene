import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String id;  // Identifiant unique de la vidéo
  String titre;  // Titre de la vidéo
  String url;  // URL de la vidéo
  String description;  // Description de la vidéo
  String auteur;  // Auteur de la vidéo
  DateTime datePublication;  // Date de publication de la vidéo

  Video({
    required this.id,
    required this.titre,
    required this.url,
    required this.description,
    required this.auteur,
    required this.datePublication,
  });

  // Méthode pour convertir une vidéo depuis un document Firestore
  factory Video.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Video(
      id: doc.id,
      titre: data['titre'],
      url: data['url'],
      description: data['description'],
      auteur: data['auteur'],
      datePublication: (data['datePublication'] as Timestamp).toDate(),
    );
  }

  // Méthode pour convertir une vidéo en format Map (pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'titre': titre,
      'url': url,
      'description': description,
      'auteur': auteur,
      'datePublication': datePublication,
    };
  }
}
