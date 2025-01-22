import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'visitor.freezed.dart';
part 'visitor.g.dart';

@freezed
class Visitor with _$Visitor {
  const factory Visitor({
    String? id,
    required String name,
    required String email,
    required String contactNumber,
    required String purposeOfVisit,
    required String department,
    String? photoUrl,
    @Default('pending') String status,
    DateTime? entryTime,
    DateTime? exitTime,
  }) = _Visitor;

  factory Visitor.fromJson(Map<String, dynamic> json) => _$VisitorFromJson(json);

  factory Visitor.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Visitor.fromJson({
      ...data,
      'id': doc.id,
      if (data['entryTime'] != null)
        'entryTime': (data['entryTime'] as Timestamp).toDate(),
      if (data['exitTime'] != null)
        'exitTime': (data['exitTime'] as Timestamp).toDate(),
    });
  }
} 