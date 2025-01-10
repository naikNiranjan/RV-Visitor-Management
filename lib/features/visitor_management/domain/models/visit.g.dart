// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VisitImpl _$$VisitImplFromJson(Map<String, dynamic> json) => _$VisitImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      contactNumber: json['contactNumber'] as String,
      email: json['email'] as String?,
      department: json['department'] as String,
      status: json['status'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      entryTime: DateTime.parse(json['entryTime'] as String),
      exitTime: json['exitTime'] == null
          ? null
          : DateTime.parse(json['exitTime'] as String),
      whomToMeet: json['whomToMeet'] as String,
      whomToMeetEmail: json['whomToMeetEmail'] as String,
      purposeOfVisit: json['purposeOfVisit'] as String,
      numberOfVisitors: (json['numberOfVisitors'] as num?)?.toInt(),
      vehicleNumber: json['vehicleNumber'] as String?,
      documentType: json['documentType'] as String?,
      hasDocument: json['hasDocument'] as bool?,
      hasPhoto: json['hasPhoto'] as bool?,
      photoUrl: json['photoUrl'] as String?,
      documentUrl: json['documentUrl'] as String?,
      address: json['address'] as String?,
      remarks: json['remarks'] as String?,
      isApproved: json['isApproved'] as bool?,
      approvedBy: json['approvedBy'] as String?,
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      sendNotification: json['sendNotification'] as bool?,
      notificationSent: json['notificationSent'] as bool?,
      notificationSentAt: json['notificationSentAt'] == null
          ? null
          : DateTime.parse(json['notificationSentAt'] as String),
      cabProvider: json['cabProvider'] as String?,
      driverName: json['driverName'] as String?,
      driverContact: json['driverContact'] as String?,
    );

Map<String, dynamic> _$$VisitImplToJson(_$VisitImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'contactNumber': instance.contactNumber,
      'email': instance.email,
      'department': instance.department,
      'status': instance.status,
      'type': instance.type,
      'createdAt': instance.createdAt.toIso8601String(),
      'entryTime': instance.entryTime.toIso8601String(),
      'exitTime': instance.exitTime?.toIso8601String(),
      'whomToMeet': instance.whomToMeet,
      'whomToMeetEmail': instance.whomToMeetEmail,
      'purposeOfVisit': instance.purposeOfVisit,
      'numberOfVisitors': instance.numberOfVisitors,
      'vehicleNumber': instance.vehicleNumber,
      'documentType': instance.documentType,
      'hasDocument': instance.hasDocument,
      'hasPhoto': instance.hasPhoto,
      'photoUrl': instance.photoUrl,
      'documentUrl': instance.documentUrl,
      'address': instance.address,
      'remarks': instance.remarks,
      'isApproved': instance.isApproved,
      'approvedBy': instance.approvedBy,
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'sendNotification': instance.sendNotification,
      'notificationSent': instance.notificationSent,
      'notificationSentAt': instance.notificationSentAt?.toIso8601String(),
      'cabProvider': instance.cabProvider,
      'driverName': instance.driverName,
      'driverContact': instance.driverContact,
    };
