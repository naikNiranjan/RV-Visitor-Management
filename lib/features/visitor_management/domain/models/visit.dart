import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'visit.freezed.dart';
part 'visit.g.dart';

@freezed
class Visit with _$Visit {
  const factory Visit({
    required String id,
    required String name,
    required String contactNumber,
    String? email,
    required String department,
    required String status, // pending, checked_in, checked_out
    required String type,   // registration, quick_checkin, cab
    required DateTime createdAt,
    required DateTime entryTime,
    DateTime? exitTime,
    required String whomToMeet,
    required String whomToMeetEmail,
    required String purposeOfVisit,
    int? numberOfVisitors,
    String? vehicleNumber,
    String? documentType,
    bool? hasDocument,
    bool? hasPhoto,
    String? photoUrl,
    String? documentUrl,
    String? address,
    String? remarks,
    bool? isApproved,
    String? approvedBy,
    DateTime? approvedAt,
    bool? sendNotification,
    bool? notificationSent,
    DateTime? notificationSentAt,
    // Cab specific fields
    String? cabProvider,
    String? driverName,
    String? driverContact,
  }) = _Visit;

  factory Visit.fromJson(Map<String, dynamic> json) => _$VisitFromJson(json);
} 