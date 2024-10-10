import 'package:cloud_firestore/cloud_firestore.dart';

class AlerteNotification {
  String id; // Identifiant unique pour chaque alerte/notification
  String titre; // Titre de la notification
  String message; // Message de la notification
  DateTime dateEmission; // Date à laquelle la notification a été émise
  String type; // Type de notification (par exemple, "conseil", "rappel", etc.)
  bool estEnvoyee; // Indique si la notification a été envoyée

  AlerteNotification({
    required this.id,
    required this.titre,
    required this.message,
    required this.dateEmission,
    required this.type,
    this.estEnvoyee = false, // Par défaut, la notification n'est pas envoyée
  });

  // Méthode pour convertir une notification depuis un document Firestore
  factory AlerteNotification.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return AlerteNotification(
      id: doc.id,
      titre: data['titre'],
      message: data['message'],
      dateEmission: (data['dateEmission'] as Timestamp).toDate(),
      type: data['type'],
      estEnvoyee: data['estEnvoyee'] ?? false,
    );
  }

  // Méthode pour convertir une notification en format Map (pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'titre': titre,
      'message': message,
      'dateEmission': Timestamp.fromDate(dateEmission),
      'type': type,
      'estEnvoyee': estEnvoyee,
    };
  }
}
