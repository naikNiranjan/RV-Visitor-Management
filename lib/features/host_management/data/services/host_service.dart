import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/host.dart';

class HostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerHost({
    required String email,
    required String name,
    required String department,
    required String contactNumber,
    String? profilePhotoUrl,
    String? position,
  }) async {
    try {
      final host = Host(
        email: email,
        name: name,
        department: department,
        contactNumber: contactNumber,
        role: 'host',
        profilePhotoUrl: profilePhotoUrl,
        position: position,
        notificationSettings: {
          'emailNotifications': true,
          'smsNotifications': false,
        },
      );

      final hostData = {
        ...host.toJson(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
        'visitHistory': null,
        'notifications': null,
        'pendingApprovals': null,
        'approvedVisitors': null,
        'rejectedVisitors': null,
      };

      print('Registering host with data: $hostData');

      final batch = _firestore.batch();

      // Add to hosts collection
      final hostRef = _firestore.collection('hosts').doc(email);
      batch.set(hostRef, hostData);

      // Add to users collection
      final userRef = _firestore.collection('users').doc(email);
      batch.set(userRef, hostData, SetOptions(merge: true));

      // Create subcollections with initial empty documents
      final notificationsRef = hostRef.collection('notifications').doc();
      batch.set(notificationsRef, {
        'createdAt': FieldValue.serverTimestamp(),
        'type': 'welcome',
        'message': 'Welcome to RVVM Host Portal',
      });

      final pendingApprovalsRef = hostRef.collection('pending_approvals').doc();
      batch.set(pendingApprovalsRef, {
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'empty',
      });

      final visitHistoryRef = hostRef.collection('visit_history').doc();
      batch.set(visitHistoryRef, {
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'empty',
      });

      await batch.commit();
      print('Host registration completed successfully');

    } catch (e) {
      print('Error registering host: $e');
      throw Exception('Failed to register host: $e');
    }
  }

  Future<Host?> fetchHostData(String email) async {
    try {
      final hostDoc = await _firestore.collection('hosts').doc(email).get();
      if (!hostDoc.exists) return null;
      return Host.fromFirestore(hostDoc);
    } catch (e) {
      print('Error fetching host data: $e');
      throw Exception('Failed to fetch host data: $e');
    }
  }

  Stream<List<Map<String, dynamic>>> getHostNotifications(String email) {
    return _firestore
        .collection('hosts')
        .doc(email)
        .collection('notifications')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Stream<List<Map<String, dynamic>>> getPendingApprovals(String email) {
    return _firestore
        .collection('hosts')
        .doc(email)
        .collection('pending_approvals')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Stream<List<Map<String, dynamic>>> getVisitHistory(String email) {
    return _firestore
        .collection('hosts')
        .doc(email)
        .collection('visit_history')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
} 