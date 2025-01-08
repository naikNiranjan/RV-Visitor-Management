import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/visitor.dart';
import 'dart:io';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> findVisitorByPhone(String phoneNumber) async {
    try {
      print('Searching for visitor with phone: $phoneNumber'); // Debug log
      
      final querySnapshot = await _firestore
          .collection('visitors')
          .where('contactNumber', isEqualTo: phoneNumber)
          .where('isDeleted', isEqualTo: false)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Sort the documents by createdAt locally
        final docs = querySnapshot.docs.toList()
          ..sort((a, b) {
            final aTime = (a.data()['createdAt'] as Timestamp).toDate();
            final bTime = (b.data()['createdAt'] as Timestamp).toDate();
            return bTime.compareTo(aTime);
          });
        
        print('Visitor found!'); // Debug log
        return docs.first.data();
      } else {
        print('No visitor found with this phone number'); // Debug log
        return null;
      }
    } catch (e) {
      print('Error finding visitor: $e'); // Debug log
      throw Exception('Failed to find visitor: $e');
    }
  }

  Future<void> saveVisitorData(Visitor visitor, {
    File? photoFile,
    File? documentFile,
  }) async {
    try {
      final String visitorId = visitor.entryTime!.millisecondsSinceEpoch.toString();
      
      // Create visitor data map with all form fields
      final Map<String, dynamic> visitorData = {
        'name': visitor.name,
        'address': visitor.address,
        'contactNumber': visitor.contactNumber,
        'email': visitor.email,
        'vehicleNumber': visitor.vehicleNumber,
        'purposeOfVisit': visitor.purposeOfVisit,
        'numberOfVisitors': visitor.numberOfVisitors,
        'whomToMeet': visitor.whomToMeet,
        'department': visitor.department,
        'documentType': visitor.documentType,
        'entryTime': visitor.entryTime?.toIso8601String(),
        'cabProvider': visitor.cabProvider,
        'driverName': visitor.driverName,
        'driverContact': visitor.driverContact,
        'emergencyContactName': visitor.emergencyContactName,
        'emergencyContactNumber': visitor.emergencyContactNumber,
        'sendNotification': visitor.sendNotification,
        'type': visitor.type,
        'id': visitorId,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'isDeleted': false,
        'status': 'pending',
      };

      // Add document information if available
      if (documentFile != null) {
        visitorData['hasDocument'] = true;
        visitorData['documentFileName'] = documentFile.path.split('/').last;
      }

      // Add photo information if available
      if (photoFile != null) {
        visitorData['hasPhoto'] = true;
        visitorData['photoFileName'] = photoFile.path.split('/').last;
      }

      // Save to Firestore
      print('Attempting to save visitor data...'); // Debug log
      await _firestore.collection('visitors').doc(visitorId).set(visitorData);
      print('Visitor data saved successfully with ID: $visitorId'); // Debug log
      
    } catch (e) {
      print('Error saving visitor data: $e'); // Debug log
      throw Exception('Failed to save visitor data: $e');
    }
  }

  Future<void> saveReturnVisit(Visitor visitor) async {
    try {
      final String visitId = visitor.entryTime!.millisecondsSinceEpoch.toString();
      
      // Create visit data map
      final Map<String, dynamic> visitData = {
        'visitorId': visitor.contactNumber, // Using phone number as visitor ID
        'visitId': visitId,
        'purposeOfVisit': visitor.purposeOfVisit,
        'numberOfVisitors': visitor.numberOfVisitors,
        'whomToMeet': visitor.whomToMeet,
        'department': visitor.department,
        'entryTime': visitor.entryTime?.toIso8601String(),
        'sendNotification': visitor.sendNotification,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'type': 'return_visit',
      };

      // Save to visits collection
      print('Saving return visit data...'); // Debug log
      await _firestore.collection('visits').doc(visitId).set(visitData);
      
      // Update visitor's last visit timestamp
      await _firestore
          .collection('visitors')
          .where('contactNumber', isEqualTo: visitor.contactNumber)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.first.reference.update({
            'lastVisit': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
            'visitCount': FieldValue.increment(1),
          });
        }
      });

      print('Return visit saved successfully with ID: $visitId'); // Debug log
    } catch (e) {
      print('Error saving return visit: $e'); // Debug log
      throw Exception('Failed to save return visit: $e');
    }
  }
} 