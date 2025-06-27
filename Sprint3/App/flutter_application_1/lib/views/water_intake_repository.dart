import 'package:cloud_firestore/cloud_firestore.dart';

class WaterIntakeRepository {
  final FirebaseFirestore _firestore;

  WaterIntakeRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addWaterIntake(String userId, int amount) async {
    await _firestore.collection('water_intake').add({
      'userId': userId,
      'amount': amount,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<List<Map<String, dynamic>>> getWaterIntake(String userId) async {
    final snapshot = await _firestore
        .collection('water_intake')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> updateWaterIntake(String userId, int amount) async {
  // Busca o registro mais recente do usuário
  final snapshot = await _firestore
      .collection('water_intake')
      .where('userId', isEqualTo: userId)
      .orderBy('timestamp', descending: true)
      .limit(1)
      .get();

  if (snapshot.docs.isNotEmpty) {
    // Obtém a quantidade atual de água consumida
    final doc = snapshot.docs.first;
    final currentAmount = doc.data()['amount'] ?? 0;

    // Soma a quantidade recebida com a atual
    final updatedAmount = currentAmount + amount;

    // Atualiza o campo no Firestore
    await _firestore.collection('water_intake').doc(doc.id).update({
      'amount': updatedAmount,
      'timestamp': FieldValue.serverTimestamp(),
    });
  } else {
    await addWaterIntake(userId, amount);
  }
}
}