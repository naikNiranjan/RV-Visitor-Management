import 'package:freezed_annotation/freezed_annotation.dart';

part 'visitor.freezed.dart';
part 'visitor.g.dart';

@freezed
class Visitor with _$Visitor {
  const factory Visitor({
    required String name,
    required String address,
    required String contactNumber,
    required String email,
    String? vehicleNumber,
    required String purposeOfVisit,
    required int numberOfVisitors,
    required String whomToMeet,
    required String department,
    required String documentType,
    DateTime? entryTime,
    String? photoUrl,
    String? documentUrl,
    String? cabProvider,
    String? driverName,
    String? driverContact,
    String? emergencyContactName,
    String? emergencyContactNumber,
    @Default(false) bool sendNotification,
    @Default('visitor') String type,
    String? lastVisitId,
    int? visitCount,
  }) = _Visitor;

  factory Visitor.fromJson(Map<String, dynamic> json) => _$VisitorFromJson(json);
}
