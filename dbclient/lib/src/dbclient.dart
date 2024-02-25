import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbclient/src/dbrecord.dart';

class DbClient {
  final FirebaseFirestore _firestore;
  DbClient({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<String> add({
    required String collection,
    required Map<String, dynamic> data,
  }) async {
    try {
      final docRef = await _firestore.collection(collection).add(data);
      return docRef.id;
    } catch (e) {
      throw Exception("failed to add ${e.toString()}");
    }
  }

  Future<List<DbRecord>> fetchAll({required String collection}) async {
    try {
      final colRef = _firestore.collection(collection);
      final documents = await colRef.get();
      return documents.docs.map((e) => DbRecord(id: e.id)).toList();
    } catch (e) {
      throw Exception("failed to load $e");
    }
  }
}
