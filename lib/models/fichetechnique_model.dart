import 'package:cloud_firestore/cloud_firestore.dart';

class FicheTechnique {
  String id;  // Identifiant unique de la fiche technique
  String nom;  // Nom de la culture
  String description;  // Description générale de la culture
  List<String> besoinsEnEau;  // Liste des besoins en eau
  List<String> etapes;  // Étapes de culture
  String famille;  // Famille botanique
  List<String> varietes;  // Variétés de la culture
  String typeSol;  // Type de sol recommandé
  double pH;  // pH du sol
  String exposition;  // Exposition recommandée (ex : plein soleil)
  String saison;  // Saison de culture
  String cycleDeCulture;  // Cycle de culture (ex : court, moyen, long)
  String temperatureOptimale;  // Température optimale
  String humidityOptimale;  // Humidité optimale
  String descriptionGenerale;  // Description générale détaillée
  String valeurNutritionnelle;  // Valeur nutritionnelle
  String conditionsDeCulture;  // Conditions de culture
  String besoinsEnEauDetail;  // Détails des besoins en eau
  String etapesDeCultureDetail;  // Détails des étapes de culture
  String recolte;  // Informations sur la récolte
  String conservation;  // Informations sur la conservation
  String zoneGeographique;  // Zone géographique recommandée
  String image;  // URL de l'image de la culture

  FicheTechnique({
    required this.id,
    required this.nom,
    required this.description,
    required this.besoinsEnEau,
    required this.etapes,
    required this.famille,
    required this.varietes,
    required this.typeSol,
    required this.pH,
    required this.exposition,
    required this.saison,
    required this.cycleDeCulture,
    required this.temperatureOptimale,
    required this.humidityOptimale,
    required this.descriptionGenerale,
    required this.valeurNutritionnelle,
    required this.conditionsDeCulture,
    required this.besoinsEnEauDetail,
    required this.etapesDeCultureDetail,
    required this.recolte,
    required this.conservation,
    required this.zoneGeographique,
    required this.image,
  }) {
    // Validation des données
    if (pH < 0 || pH > 14) {
      throw ArgumentError('Le pH doit être compris entre 0 et 14.');
    }
  }

  // Méthode pour convertir une fiche technique depuis un document Firestore
  factory FicheTechnique.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Vérification pour gérer les formats potentiels incorrects
    double? parsedPh;
    if (data['pH'] is double) {
      parsedPh = data['pH'];
    } else if (data['pH'] is String) {
      parsedPh = double.tryParse(data['pH']);
    } else {
      parsedPh = 0.0; // Valeur par défaut si non disponible
    }

    return FicheTechnique(
      id: doc.id,
      nom: data['nom'] ?? '',  // Valeur par défaut si absent
      description: data['description'] ?? '',
      besoinsEnEau: List<String>.from(data['besoinsEnEau'] ?? []),
      etapes: List<String>.from(data['etapes'] ?? []),
      famille: data['famille'] ?? '',
      varietes: List<String>.from(data['varietes'] ?? []),
      typeSol: data['typeSol'] ?? '',
      pH: parsedPh ?? 0.0,
      exposition: data['exposition'] ?? '',
      saison: data['saison'] ?? '',
      cycleDeCulture: data['cycleDeCulture'] ?? '',
      temperatureOptimale: data['temperatureOptimale'] ?? '',
      humidityOptimale: data['humidityOptimale'] ?? '',
      descriptionGenerale: data['descriptionGenerale'] ?? '',
      valeurNutritionnelle: data['valeurNutritionnelle'] ?? '',
      conditionsDeCulture: data['conditionsDeCulture'] ?? '',
      besoinsEnEauDetail: data['besoinsEnEauDetail'] ?? '',
      etapesDeCultureDetail: data['etapesDeCultureDetail'] ?? '',
      recolte: data['recolte'] ?? '',
      conservation: data['conservation'] ?? '',
      zoneGeographique: data['zoneGeographique'] ?? '',
      image: data['image'] ?? '',
    );
  }

  // Méthode pour convertir une fiche technique en format Map (pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'description': description,
      'besoinsEnEau': besoinsEnEau,
      'etapes': etapes,
      'famille': famille,
      'varietes': varietes,
      'typeSol': typeSol,
      'pH': pH,
      'exposition': exposition,
      'saison': saison,
      'cycleDeCulture': cycleDeCulture,
      'temperatureOptimale': temperatureOptimale,
      'humidityOptimale': humidityOptimale,
      'descriptionGenerale': descriptionGenerale,
      'valeurNutritionnelle': valeurNutritionnelle,
      'conditionsDeCulture': conditionsDeCulture,
      'besoinsEnEauDetail': besoinsEnEauDetail,
      'etapesDeCultureDetail': etapesDeCultureDetail,
      'recolte': recolte,
      'conservation': conservation,
      'zoneGeographique': zoneGeographique,
      'image': image,
    };
  }
}
