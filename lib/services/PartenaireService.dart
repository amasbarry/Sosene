import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seneso_admin/models/partenaire_model.dart';

class PartenaireService {
  final CollectionReference partenairesRef = FirebaseFirestore.instance.collection('partenaires');

  // Ajouter un partenaire
  Future<void> ajouterPartenaire(Partenaire partenaire) async {
    await partenairesRef.add(partenaire.toMap());
  }

  // Modifier un partenaire existant
  Future<void> modifierPartenaire(String partenaireId, Partenaire partenaire) async {
    await partenairesRef.doc(partenaireId).update(partenaire.toMap());
  }

  // Supprimer un partenaire
  Future<void> supprimerPartenaire(String partenaireId) async {
    await partenairesRef.doc(partenaireId).delete();
  }

  // Récupérer un partenaire par ID
  Future<Partenaire?> obtenirPartenaireParId(String partenaireId) async {
    DocumentSnapshot doc = await partenairesRef.doc(partenaireId).get();
    if (doc.exists) {
      return Partenaire.fromDocument(doc);
    }
    return null;
  }

  // Récupérer tous les partenaires
  Future<List<Partenaire>> obtenirTousLesPartenaires() async {
    QuerySnapshot querySnapshot = await partenairesRef.get();
    return querySnapshot.docs.map((doc) => Partenaire.fromDocument(doc)).toList();
  }
}
