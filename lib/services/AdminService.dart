import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seneso_admin/models/admin_model.dart';


class AdministrateurService {
  final CollectionReference administrateurCollection =
      FirebaseFirestore.instance.collection('administrateurs');

  // Méthode pour ajouter un administrateur
  Future<void> ajouterAdministrateur(Administrateur admin) async {
    try {
      await administrateurCollection.add(admin.toMap());
    } catch (e) {
      print('Erreur lors de l\'ajout de l\'administrateur: $e');
      throw Exception('Erreur lors de l\'ajout de l\'administrateur');
    }
  }

  // Méthode pour récupérer un administrateur par ID
  Future<Administrateur?> getAdministrateurById(String id) async {
    try {
      DocumentSnapshot doc = await administrateurCollection.doc(id).get();
      if (doc.exists) {
        return Administrateur.fromDocument(doc);
      }
      return null;
    } catch (e) {
      print('Erreur lors de la récupération de l\'administrateur: $e');
      return null;
    }
  }

  // Méthode pour récupérer tous les administrateurs
  Future<List<Administrateur>> getTousLesAdministrateurs() async {
    try {
      QuerySnapshot querySnapshot = await administrateurCollection.get();
      return querySnapshot.docs
          .map((doc) => Administrateur.fromDocument(doc))
          .toList();
    } catch (e) {
      print('Erreur lors de la récupération des administrateurs: $e');
      return [];
    }
  }

  // Méthode pour mettre à jour un administrateur
  Future<void> updateAdministrateur(String id, Administrateur admin) async {
    try {
      await administrateurCollection.doc(id).update(admin.toMap());
    } catch (e) {
      print('Erreur lors de la mise à jour de l\'administrateur: $e');
      throw Exception('Erreur lors de la mise à jour de l\'administrateur');
    }
  }

  // Méthode pour supprimer un administrateur
  Future<void> supprimerAdministrateur(String id) async {
    try {
      await administrateurCollection.doc(id).delete();
    } catch (e) {
      print('Erreur lors de la suppression de l\'administrateur: $e');
      throw Exception('Erreur lors de la suppression de l\'administrateur');
    }
  }

  

}
