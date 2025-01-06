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
    String? photoUrl,
    required int numberOfVisitors,
    required String whomToMeet,
    required String department,
    required String documentType,
    String? documentUrl,
    String? emergencyContactName,
    String? emergencyContactNumber,
    String? cabProvider,
    String? driverName,
    String? driverContact,
    @Default(false) bool sendNotification,
    @Default(false) bool isApproved,
    DateTime? entryTime,
    DateTime? exitTime,
  }) = _Visitor;

  factory Visitor.fromJson(Map<String, dynamic> json) =>
      _$VisitorFromJson(json);
}
