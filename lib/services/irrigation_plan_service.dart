import 'package:cloud_firestore/cloud_firestore.dart';

class IrrigationPlanService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Yeni bir sulama planı ekleme
  Future<void> addIrrigationPlan(String fieldId, String schedule, int waterAmount) async {
    try {
      var planRef = _db.collection('IrrigationPlans').doc();
      await planRef.set({
        'field_id': fieldId,
        'schedule': schedule,
        'water_amount': waterAmount,
      });
    } catch (e) {
      print('Error adding irrigation plan: $e');
    }
  }

  // Sulama planını güncelleme
  Future<void> updateIrrigationPlan(String planId, String schedule, int waterAmount) async {
    try {
      await _db.collection('IrrigationPlans').doc(planId).update({
        'schedule': schedule,
        'water_amount': waterAmount,
      });
    } catch (e) {
      print('Error updating irrigation plan: $e');
    }
  }

  // Sulama planını silme
  Future<void> deleteIrrigationPlan(String planId) async {
    try {
      await _db.collection('IrrigationPlans').doc(planId).delete();
    } catch (e) {
      print('Error deleting irrigation plan: $e');
    }
  }

  // Tüm sulama planlarını getirme
  Stream<QuerySnapshot> getIrrigationPlans() {
    return _db.collection('IrrigationPlans').snapshots();
  }

  // Bir tarladaki sulama planlarını getirme
  Stream<QuerySnapshot> getIrrigationPlansByField(String fieldId) {
    return _db.collection('IrrigationPlans').where('field_id', isEqualTo: fieldId).snapshots();
  }
}
