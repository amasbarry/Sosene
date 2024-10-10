import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seneso_admin/models/agriculteur_model.dart';
import 'package:seneso_admin/models/reponsepost.dart';

class ForumPost {
  String id; // Identifiant unique du post
  String title; // Titre de la question
  String content; // Contenu de la question
  Agriculteur farmer; // L'agriculteur qui a posé la question
  String? adminId; // ID de l'administrateur qui a répondu (le cas échéant)
  DateTime createdAt; // Date de création du post
  DateTime? updatedAt; // Date de mise à jour du post
  String category; // Catégorie du post (ex : cultures, techniques)
  List<Reponse> reponses; // Liste des réponses à ce post

  ForumPost({
    required this.id,
    required this.title,
    required this.content,
    required this.farmer,
    this.adminId,
    required this.createdAt,
    this.updatedAt,
    required this.category,
    this.reponses = const [], // Initialiser la liste des réponses
  });

  // Méthode pour convertir un post en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'farmer': farmer.toMap(), // Utiliser la méthode toMap de l'Agriculteur
      'adminId': adminId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'category': category,
      'reponses': reponses.map((r) => r.toJson()).toList(), // Convertir les réponses en JSON
    };
  }

  // Méthode pour créer un post à partir de JSON
  static ForumPost fromJson(Map<String, dynamic> json) {
    return ForumPost(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      farmer: Agriculteur.fromDocument(json['farmer']), // Créer l'Agriculteur à partir de JSON
      adminId: json['adminId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      category: json['category'],
      reponses: (json['reponses'] as List)
          .map((r) => Reponse.fromJson(r))
          .toList(), // Créer la liste des réponses à partir de JSON
    );
  }

  // Méthode pour ajouter une réponse au post
  void addReponse(Reponse reponse) {
    reponses.add(reponse);
  }
}