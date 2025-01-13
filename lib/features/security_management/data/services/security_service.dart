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
        'role': 'Security',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'profilePhotoUrl': profilePhotoUrl,
        'position': position,
        'lastLogin': FieldValue.serverTimestamp(),
        'assignedAreas': [],
        'shiftTimings': null,
        'isActive': true,
      };

      // Create a batch to ensure both operations succeed or fail together
      final batch = _firestore.batch();

      // Add to security collection using email as document ID
      final securityRef = _firestore.collection('security').doc(email);
      batch.set(securityRef, securityData);

      // Add to users collection using email as document ID with the same data
      final userRef = _firestore.collection('users').doc(email);
      batch.set(
          userRef,
          {
            ...securityData,
            'username': name,
          },
          SetOptions(merge: true));

      await batch.commit();
    } catch (e) {
      print('Error registering security: $e');
      throw Exception('Failed to register security personnel: $e');
    }
  }

  Future<Map<String, dynamic>?> fetchSecurityData(String email) async {
    try {
      final securityDoc =
          await _firestore.collection('security').doc(email).get();
      if (!securityDoc.exists) {
        return null;
      }
      return securityDoc.data();
    } catch (e) {
      print('Error fetching security data: $e');
      return null;
    }
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
