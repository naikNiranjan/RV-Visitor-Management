import 'package:cloud_firestore/cloud_firestore.dart';

class SecurityService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerSecurity({
    required String email,
    required String name,
    required String contactNumber,
    String? profilePhotoUrl,
    String? position,
  }) async {
    try {
      final securityData = {
        'email': email,
        'name': name,
        'contactNumber': contactNumber,
        'role': 'security',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'profilePhotoUrl': profilePhotoUrl ?? null,
        'position': position ?? null,
        'lastLogin': FieldValue.serverTimestamp(),
        'assignedAreas': null, // Areas assigned to the security personnel
        'shiftTimings': null, // Shift timings for the security personnel
      };

      await _firestore.collection('security').doc(email).set(securityData);
      await _firestore.collection('users').doc(email).set(securityData, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to register security personnel: $e');
    }
  }

  Future<Map<String, dynamic>?> fetchSecurityData(String email) async {
    final securityDoc = await _firestore.collection('security').doc(email).get();
    return securityDoc.data();
  }

  Stream<List<Map<String, dynamic>>> getSecurityNotifications(String email) {
    return _firestore
        .collection('security')
        .doc(email)
        .collection('notifications')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
} 