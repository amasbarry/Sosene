import 'package:cloud_firestore/cloud_firestore.dart';

class CalendrierAgricole {
  String id; // Identifiant unique pour chaque événement
  String titre; // Titre de l'événement
  String typeCulture; // Type de culture concerné
  String region; // Région concernée
  DateTime dateDebut; // Date de début de l'événement
  DateTime dateFin; // Date de fin de l'événement
  String description; // Description de l'événement
  bool notifie; // Indique si une notification a été envoyée pour cet événement

  CalendrierAgricole({
    required this.id,
    required this.titre,
    required this.typeCulture,
    required this.region,
    required this.dateDebut,
    required this.dateFin,
    required this.description,
    this.notifie = false, // Par défaut, la notification n'est pas envoyée
  });

  factory CalendrierAgricole.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CalendrierAgricole(
      id: doc.id,
      titre: data['titre'],
      typeCulture: data['typeCulture'],
      region: data['region'],
      dateDebut: (data['dateDebut'] as Timestamp).toDate(),
      dateFin: (data['dateFin'] as Timestamp).toDate(), // Assurez-vous d'ajouter ce champ
      description: data['description'],
      notifie: data['notifie'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titre': titre,
      'typeCulture': typeCulture,
      'region': region,
      'dateDebut': Timestamp.fromDate(dateDebut),
      'dateFin': Timestamp.fromDate(dateFin), // Ajoutez ce champ ici
      'description': description,
      'notifie': notifie,
    };
  }
}
