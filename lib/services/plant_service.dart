import 'package:cloud_firestore/cloud_firestore.dart';

class PlantService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Yeni bir bitki ekleme
  Future<void> addPlant(String fieldId, String plantName, String plantType) async {
    try {
      var plantRef = _db.collection('Plants').doc();
      await plantRef.set({
        'name': plantName,
        'type': plantType,
        'field_id': fieldId,
      });
    } catch (e) {
      print('Error adding plant: $e');
    }
  }

  // Bitkiyi güncelleme
  Future<void> updatePlant(String plantId, String plantName) async {
    try {
      await _db.collection('Plants').doc(plantId).update({
        'name': plantName,
      });
    } catch (e) {
      print('Error updating plant: $e');
    }
  }

  // Bitkiyi silme
  Future<void> deletePlant(String plantId) async {
    try {
      await _db.collection('Plants').doc(plantId).delete();
    } catch (e) {
      print('Error deleting plant: $e');
    }
  }

  // Tüm bitkileri getirme
  Stream<QuerySnapshot> getPlants() {
    return _db.collection('Plants').snapshots();
  }

  // Bir tarladaki bitkileri getirme
  Stream<QuerySnapshot> getPlantsByField(String fieldId) {
    return _db.collection('Plants').where('field_id', isEqualTo: fieldId).snapshots();
  }
}
