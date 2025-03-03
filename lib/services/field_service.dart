import 'package:cloud_firestore/cloud_firestore.dart';

class FieldService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addField(String userId, String fieldName, double lat, double lng) async {
    try {
      var fieldRef = _db.collection('Fields').doc();
      await fieldRef.set({
        'name': fieldName,
        'location': {'lat': lat, 'lng': lng},
        'owner_id': userId,
        'plants': [],
      });
    } catch (e) {
      print('Error adding field: $e');
    }
  }

  Future<void> updateField(String fieldId, String fieldName) async {
    try {
      await _db.collection('Fields').doc(fieldId).update({
        'name': fieldName,
      });
    } catch (e) {
      print('Error updating field: $e');
    }
  }

  Future<void> deleteField(String fieldId) async {
    try {
      await _db.collection('Fields').doc(fieldId).delete();
    } catch (e) {
      print('Error deleting field: $e');
    }
  }

  Stream<QuerySnapshot> getFields() {
    return _db.collection('Fields').snapshots();
  }
}
