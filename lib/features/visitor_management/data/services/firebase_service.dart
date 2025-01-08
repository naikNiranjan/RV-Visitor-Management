import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../domain/models/visitor.dart';
import 'dart:io';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> _uploadFile(File file, String path) async {
    final ref = _storage.ref().child(path);
    final uploadTask = ref.putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> saveVisitorData(Visitor visitor, {
    File? photoFile,
    File? documentFile,
  }) async {
    try {
      final String visitorId = visitor.entryTime!.millisecondsSinceEpoch.toString();
      
      // Upload files if present
      String? photoUrl;
      String? documentUrl;
      
      if (photoFile != null) {
        photoUrl = await _uploadFile(
          photoFile,
          'visitors/$visitorId/photo.${photoFile.path.split('.').last}'
        );
      }
      
      if (documentFile != null) {
        documentUrl = await _uploadFile(
          documentFile,
          'visitors/$visitorId/document.${documentFile.path.split('.').last}'
        );
      }

      // Create visitor data map
      final Map<String, dynamic> visitorData = {
        ...visitor.toJson(),
        'id': visitorId,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'isDeleted': false,
        'status': 'pending',
      };
      
      // Update with file URLs
      if (photoUrl != null) visitorData['photoUrl'] = photoUrl;
      if (documentUrl != null) visitorData['documentUrl'] = documentUrl;

      // Save to Firestore
      await _firestore.collection('visitors').doc(visitorId).set(visitorData);
    } catch (e) {
      print('Error saving visitor data: $e'); // For debugging
      throw Exception('Failed to save visitor data: $e');
    }
  }
} 