import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/calendrier_agricole.dart';

class CalendrierAgricoleService {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('calendriersAgricoles');

  Future<void> ajouterEvenement(CalendrierAgricole evenement) async {
    await _collection.doc(evenement.id).set(evenement.toMap());
  }

  Future<List<CalendrierAgricole>> recupererEvenements() async {
    QuerySnapshot snapshot = await _collection.get();
    return snapshot.docs
        .map((doc) => CalendrierAgricole.fromDocument(doc))
        .toList();
  }

  Future<void> notifierEvenement(String evenementId) async {
    DocumentReference docRef = _collection.doc(evenementId);
    await docRef.update({'notifie': true});
  }
}
