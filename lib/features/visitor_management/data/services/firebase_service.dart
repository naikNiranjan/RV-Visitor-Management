import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/visitor.dart';
import '../../domain/models/department_data.dart';
import 'dart:io';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String getHostNameFromEmail(String email) {
    for (var staffList in departmentStaff.values) {
      for (var staff in staffList) {
        if (staff.value == email) {
          return staff.label;
        }
      }
    }
    return email;
  }

  Future<Map<String, dynamic>?> findVisitorByPhone(String phoneNumber) async {
    try {
      print('Searching for visitor with phone: $phoneNumber');
      
      final visitorSnapshot = await _firestore
          .collection('visitors')
          .where('contactNumber', isEqualTo: phoneNumber)
          .where('isDeleted', isEqualTo: false)
          .get();

      if (visitorSnapshot.docs.isEmpty) {
        print('No visitor found');
        return null;
      }

        final visitorDoc = visitorSnapshot.docs.first;
        final rawData = visitorDoc.data();
        final visitorData = rawData is Map<String, dynamic> 
          ? Map<String, dynamic>.from(rawData)
          : <String, dynamic>{};
      
      // Get form-specific details based on visitor type
      final String visitorId = visitorDoc.id;
      Map<String, dynamic>? formDetails;
      
      if (visitorData['type'] == 'registration') {
        final detailsDoc = await _firestore
            .collection('registration_details')
            .doc(visitorId)
            .get();
        if (detailsDoc.exists) {
            final rawDetails = detailsDoc.data();
            formDetails = rawDetails is Map<String, dynamic> 
              ? Map<String, dynamic>.from(rawDetails)
              : <String, dynamic>{};
        }
      } else if (visitorData['type'] == 'cab') {
        final detailsDoc = await _firestore
            .collection('cab_entry_details')
            .doc(visitorId)
            .get();
        if (detailsDoc.exists) {
            final rawDetails = detailsDoc.data();
            formDetails = rawDetails is Map<String, dynamic> 
              ? Map<String, dynamic>.from(rawDetails)
              : <String, dynamic>{};
        }
      }

      // Combine visitor data with form details
      return {
        ...visitorData,
        ...?formDetails,
      };
    } catch (e) {
      print('Error finding visitor: $e');
      throw Exception('Failed to find visitor: $e');
    }
  }

  Future<void> _updateVisitCount(String contactNumber, String visitId) async {
    try {
      final visitorQuery = await _firestore
          .collection('visitors')
          .where('contactNumber', isEqualTo: contactNumber)
          .limit(1)
          .get();

      if (visitorQuery.docs.isNotEmpty) {
        await visitorQuery.docs.first.reference.update({
          'lastVisit': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          'visitCount': FieldValue.increment(1),
          'lastVisitId': visitId,
        });
        print('Visit count updated successfully');
      }
    } catch (e) {
      print('Error updating visit count: $e');
      throw Exception('Failed to update visit count: $e');
    }
  }

  Future<bool> isVisitorRegistered(String phoneNumber) async {
    try {
      final querySnapshot = await _firestore
          .collection('visitors')
          .where('contactNumber', isEqualTo: phoneNumber)
          .where('isDeleted', isEqualTo: false)
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking visitor registration: $e');
      throw Exception('Failed to check visitor registration: $e');
    }
  }

  Future<void> saveVisitorData(Visitor visitor, {
    File? photoFile,
    File? documentFile,
  }) async {
    try {
      // Check if visitor already exists
      final isRegistered = await isVisitorRegistered(visitor.contactNumber);
      if (isRegistered) {
        throw Exception('Visitor already registered. Please use Quick Check-in.');
      }

      final String visitorId = visitor.entryTime!.millisecondsSinceEpoch.toString();
      final String hostName = getHostNameFromEmail(visitor.whomToMeet);

      // Check for existing visitor
      final existingVisitorQuery = await _firestore
          .collection('visitors')
          .where('contactNumber', isEqualTo: visitor.contactNumber)
          .limit(1)
          .get();

      final int currentVisitCount = existingVisitorQuery.docs.isNotEmpty 
          ? (existingVisitorQuery.docs.first.data()['visitCount'] ?? 0) + 1
          : 1;

      // Common visitor data structure
      final Map<String, dynamic> visitorData = {
        // Basic Info
        'name': visitor.name,
        'contactNumber': visitor.contactNumber,
        'email': visitor.email,
        'purposeOfVisit': visitor.purposeOfVisit,
        'whomToMeet': hostName,
        'whomToMeetEmail': visitor.whomToMeet,
        'department': visitor.department,
        
        // Timestamps
        'entryTime': visitor.entryTime?.toIso8601String(),
        'exitTime': null,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        
        // Status and Type
        'type': visitor.type,
        'id': visitorId,
        'isDeleted': false,
        'status': 'pending',
        
        // Visit Details
        'sendNotification': visitor.sendNotification,
        'numberOfVisitors': visitor.numberOfVisitors,
        'vehicleNumber': visitor.vehicleNumber,
        
        // Document Details
        'documentType': visitor.documentType,
        'hasDocument': documentFile != null,
        'hasPhoto': photoFile != null,
        'photoUrl': null,
        'documentUrl': null,
        
        // Visit Tracking
        'lastVisit': FieldValue.serverTimestamp(),
        'visitCount': currentVisitCount,
        'lastVisitId': visitorId,
      };

      // Save to visitors collection
      await _firestore.collection('visitors').doc(visitorId).set(visitorData);

      // Handle form-specific data
      if (visitor.type == 'registration') {
        final registrationData = {
          // Reference
          'visitorId': visitorId,
          
          // Form Details
          'address': visitor.address,
          'email': visitor.email,
          'documentType': visitor.documentType,
          'numberOfVisitors': visitor.numberOfVisitors,
          'emergencyContactName': visitor.emergencyContactName,
          'emergencyContactNumber': visitor.emergencyContactNumber,
          
          // Document Details
          'hasDocument': documentFile != null,
          'hasPhoto': photoFile != null,
          'photoFileName': photoFile?.path.split('/').last,
          'documentFileName': documentFile?.path.split('/').last,
          
          // Timestamps
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          'entryTime': visitor.entryTime?.toIso8601String(),
          'exitTime': null,
          
          // Status and Approval
          'status': 'pending',
          'isApproved': false,
          'approvedBy': null,
          'approvedAt': null,
          'remarks': null,
          
          // Visit Details
          'purpose': visitor.purposeOfVisit,
          'department': visitor.department,
          'whomToMeet': hostName,
          'whomToMeetEmail': visitor.whomToMeet,
          
          // Notification
          'sendNotification': visitor.sendNotification,
          'notificationSent': false,
          'notificationSentAt': null,
          
          // Visit Tracking
          'visitNumber': currentVisitCount,
        };

        await _firestore
            .collection('registration_details')
            .doc(visitorId)
            .set(registrationData);
      } 
      else if (visitor.type == 'cab') {
        final cabData = {
          // Reference
          'visitorId': visitorId,
          
          // Basic Info
          'name': visitor.name,
          'contactNumber': visitor.contactNumber,
          'email': visitor.email,
          'address': visitor.address,
          
          // Cab Details
          'cabProvider': visitor.cabProvider,
          'driverName': visitor.driverName,
          'driverContact': visitor.driverContact,
          'vehicleNumber': visitor.vehicleNumber,
          
          // Visit Details
          'purposeOfVisit': visitor.purposeOfVisit,
          'numberOfVisitors': visitor.numberOfVisitors,
          'whomToMeet': hostName,
          'whomToMeetEmail': visitor.whomToMeet,
          'department': visitor.department,
          
          // Document Details
          'documentType': visitor.documentType,
          'hasDocument': documentFile != null,
          'documentFileName': documentFile?.path.split('/').last,
          'documentUrl': null,
          'hasPhoto': photoFile != null,
          'photoFileName': photoFile?.path.split('/').last,
          'photoUrl': null,
          
          // Emergency Contact
          'emergencyContactName': visitor.emergencyContactName,
          'emergencyContactNumber': visitor.emergencyContactNumber,
          
          // Timestamps
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          'entryTime': visitor.entryTime?.toIso8601String(),
          'exitTime': null,
          
          // Status and Approval
          'status': 'pending',
          'isApproved': false,
          'approvedBy': null,
          'approvedAt': null,
          'remarks': null,
          
          // Visit Tracking
          'visitNumber': currentVisitCount,
          'type': 'cab',
        };

        await _firestore
            .collection('cab_entry_details')
            .doc(visitorId)
            .set(cabData);
      }

      // Update visit count for existing visitor
      if (existingVisitorQuery.docs.isNotEmpty) {
        await existingVisitorQuery.docs.first.reference.update({
          'visitCount': currentVisitCount,
          'lastVisit': FieldValue.serverTimestamp(),
          'lastVisitId': visitorId,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }

      // Add this: Save to visits collection for all types of registrations
      final Map<String, dynamic> visitData = {
        'visitId': visitorId,
        'visitorId': visitor.contactNumber,
        'name': visitor.name,
        'contactNumber': visitor.contactNumber,
        'email': visitor.email,
        'purposeOfVisit': visitor.purposeOfVisit,
        'numberOfVisitors': visitor.numberOfVisitors,
        'whomToMeet': hostName,
        'whomToMeetEmail': visitor.whomToMeet,
        'department': visitor.department,
        'entryTime': FieldValue.serverTimestamp(),
        'exitTime': null,
        'type': visitor.type,
        'status': 'checked_in',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'documentType': visitor.documentType,
        'hasDocument': documentFile != null,
        'hasPhoto': photoFile != null,
        'vehicleNumber': visitor.vehicleNumber,
        // Add cab-specific fields if type is cab
        ...(visitor.type == 'cab' ? {
          'cabProvider': visitor.cabProvider,
          'driverName': visitor.driverName,
          'driverContact': visitor.driverContact,
        } : {}),
      };

      await _firestore
          .collection('visits')
          .doc(visitorId)
          .set(visitData);

      print('Visitor data saved successfully with ID: $visitorId');
    } catch (e) {
      print('Error saving visitor data: $e');
      throw Exception('Failed to save visitor data: $e');
    }
  }

  Future<void> saveReturnVisit(Visitor visitor) async {
    try {
      final String visitId = DateTime.now().millisecondsSinceEpoch.toString();
      final String hostName = getHostNameFromEmail(visitor.whomToMeet);
      
      // Quick check-in specific data
      final Map<String, dynamic> quickCheckInData = {
        // System Fields
        'visitId': visitId,
        'visitorId': visitor.contactNumber,
        'type': 'quick_checkin',
        'id': visitId,
        
        // Basic Info
        'name': visitor.name,
        'contactNumber': visitor.contactNumber,
        'email': visitor.email,
        'address': visitor.address,
        
        // Visit Details
        'purposeOfVisit': visitor.purposeOfVisit,
        'numberOfVisitors': visitor.numberOfVisitors,
        'whomToMeet': hostName,
        'whomToMeetEmail': visitor.whomToMeet,
        'department': visitor.department,
        
        // Timestamps
        'entryTime': FieldValue.serverTimestamp(),
        'exitTime': null,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        
        // Status and Approval
        'status': 'checked_in',
        'isApproved': true,
        'approvedBy': null,
        'approvedAt': FieldValue.serverTimestamp(),
        'remarks': null,
        
        // Notification
        'sendNotification': visitor.sendNotification,
        'notificationSent': false,
        'notificationSentAt': null,
        
        // Additional Tracking
        'isDeleted': false,
        'checkInMethod': 'quick',
        'previousVisitId': null,
        'deviceInfo': null,
        'ipAddress': null,
        'location': null,
        
        // Reference to original registration
        'originalRegistrationId': null,
        'lastVisitId': null,
      };

      // Save to quick_checkins collection
      await _firestore
          .collection('quick_checkins')
          .doc(visitId)
          .set(quickCheckInData);

      // Also save to visits collection for tracking
      final Map<String, dynamic> visitData = {
        'visitId': visitId,
        'visitorId': visitor.contactNumber,
        'name': visitor.name,
        'contactNumber': visitor.contactNumber,
        'purposeOfVisit': visitor.purposeOfVisit,
        'numberOfVisitors': visitor.numberOfVisitors,
        'whomToMeet': hostName,
        'whomToMeetEmail': visitor.whomToMeet,
        'department': visitor.department,
        'entryTime': FieldValue.serverTimestamp(),
        'exitTime': null,
        'type': 'quick_checkin',
        'status': 'checked_in',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await _firestore
          .collection('visits')
          .doc(visitId)
          .set(visitData);

      // Update visitor's last visit info in visitors collection
      final visitorQuery = await _firestore
          .collection('visitors')
          .where('contactNumber', isEqualTo: visitor.contactNumber)
          .limit(1)
          .get();

      if (visitorQuery.docs.isNotEmpty) {
        await visitorQuery.docs.first.reference.update({
          'lastVisit': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          'visitCount': FieldValue.increment(1),
          'lastVisitId': visitId,
          'lastCheckInType': 'quick',
        });
      }

      print('Quick check-in saved successfully with ID: $visitId');
    } catch (e) {
      print('Error saving quick check-in: $e');
      throw Exception('Failed to save quick check-in: $e');
    }
  }

  Stream<List<Map<String, dynamic>>> getVisitorLogs({
    String? department,
    String? status,
    DateTime? selectedDate,
    String? searchQuery,
    String sortBy = 'createdAt',
    bool ascending = false,
    String? visitType,
  }) {
    try {
      Query query = _firestore.collection('visits');

      // Apply date filter first
      if (selectedDate != null) {
        final startOfDay = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
        final endOfDay = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, 23, 59, 59);
        query = query.where('createdAt', 
          isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
          isLessThanOrEqualTo: Timestamp.fromDate(endOfDay),
        );
      }

      // Apply department filter
      if (department != null) {
        query = query.where('department', isEqualTo: department);
      }

      // Apply status filter
      if (status != null && status.toLowerCase() != 'all') {
        query = query.where('status', isEqualTo: status.toLowerCase());
      }

      // Apply type filter
      if (visitType != null && visitType.toLowerCase() != 'all') {
        query = query.where('type', isEqualTo: visitType.toLowerCase());
      }

      // Always order by createdAt
      query = query.orderBy('createdAt', descending: !ascending);

      return query.snapshots().map((snapshot) {
        var docs = snapshot.docs.map((doc) {
          final data = Map<String, dynamic>.from(doc.data() as Map<String, dynamic>);
          data['id'] = doc.id;
          
          // Convert Timestamps
          if (data['createdAt'] != null && data['createdAt'] is Timestamp) {
            data['createdAt'] = (data['createdAt'] as Timestamp).toDate().toIso8601String();
          }
          if (data['entryTime'] != null && data['entryTime'] is Timestamp) {
            data['entryTime'] = (data['entryTime'] as Timestamp).toDate().toIso8601String();
          }
          if (data['exitTime'] != null && data['exitTime'] is Timestamp) {
            data['exitTime'] = (data['exitTime'] as Timestamp).toDate().toIso8601String();
          }
          
          return data;
        }).toList();

        // Apply search filter if provided
        if (searchQuery != null && searchQuery.isNotEmpty) {
          final searchLower = searchQuery.toLowerCase();
          docs = docs.where((doc) {
            return doc['name']?.toString().toLowerCase().contains(searchLower) == true ||
                   doc['contactNumber']?.toString().toLowerCase().contains(searchLower) == true ||
                   doc['whomToMeet']?.toString().toLowerCase().contains(searchLower) == true ||
                   doc['department']?.toString().toLowerCase().contains(searchLower) == true;
          }).toList();
        }

        return docs;
      });
    } catch (e) {
      print('Error getting visitor logs: $e');
      throw Exception('Failed to get visitor logs: $e');
    }
  }

  Future<void> checkoutVisitor(String visitId) async {
    try {
      final batch = _firestore.batch();
      
      final visitDoc = await _firestore.collection('visits').doc(visitId).get();
      if (!visitDoc.exists) {
        throw Exception('Visit not found');
      }

        final rawData = visitDoc.data();
        final visitData = rawData is Map<String, dynamic> 
          ? Map<String, dynamic>.from(rawData)
          : <String, dynamic>{};
      final visitorType = visitData['type'] as String?;
      
      // Update timestamps with proper server timestamp
      final Map<String, dynamic> updateData = {
        'exitTime': FieldValue.serverTimestamp(),
        'status': 'checked_out',
        'updatedAt': FieldValue.serverTimestamp(),
      };

      // Update in visits collection
      batch.update(_firestore.collection('visits').doc(visitId), updateData);

      // Update in type-specific collection
      final typeCollections = {
        'quick_checkin': 'quick_checkins',
        'registration': 'registration_details',
        'cab': 'cab_entry_details',
      };

      if (visitorType != null && typeCollections.containsKey(visitorType)) {
        final typeRef = _firestore.collection(typeCollections[visitorType]!).doc(visitId);
        final typeDoc = await typeRef.get();
        if (typeDoc.exists) {
          batch.update(typeRef, updateData);
        }
      }

      // Update visitor's last checkout
      if (visitData.containsKey('contactNumber')) {
        final visitorQuery = await _firestore
            .collection('visitors')
            .where('contactNumber', isEqualTo: visitData['contactNumber'])
            .limit(1)
            .get();
        
        if (visitorQuery.docs.isNotEmpty) {
          batch.update(visitorQuery.docs.first.reference, {
            'lastCheckout': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
          });
        }
      }

      await batch.commit();
      print('Visitor checked out successfully');

    } catch (e) {
      print('Error checking out visitor: $e');
      throw Exception('Failed to checkout visitor: $e');
    }
  }
} 