// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VisitorImpl _$$VisitorImplFromJson(Map<String, dynamic> json) =>
    _$VisitorImpl(
      name: json['name'] as String,
      address: json['address'] as String,
      contactNumber: json['contactNumber'] as String,
      email: json['email'] as String,
      vehicleNumber: json['vehicleNumber'] as String?,
      purposeOfVisit: json['purposeOfVisit'] as String,
      numberOfVisitors: (json['numberOfVisitors'] as num).toInt(),
      whomToMeet: json['whomToMeet'] as String,
      department: json['department'] as String,
      documentType: json['documentType'] as String,
      entryTime: json['entryTime'] == null
          ? null
          : DateTime.parse(json['entryTime'] as String),
      photoUrl: json['photoUrl'] as String?,
      documentUrl: json['documentUrl'] as String?,
      cabProvider: json['cabProvider'] as String?,
      driverName: json['driverName'] as String?,
      driverContact: json['driverContact'] as String?,
      emergencyContactName: json['emergencyContactName'] as String?,
      emergencyContactNumber: json['emergencyContactNumber'] as String?,
      sendNotification: json['sendNotification'] as bool? ?? false,
      type: json['type'] as String? ?? 'visitor',
      lastVisitId: json['lastVisitId'] as String?,
      visitCount: (json['visitCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$VisitorImplToJson(_$VisitorImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'contactNumber': instance.contactNumber,
      'email': instance.email,
      'vehicleNumber': instance.vehicleNumber,
      'purposeOfVisit': instance.purposeOfVisit,
      'numberOfVisitors': instance.numberOfVisitors,
      'whomToMeet': instance.whomToMeet,
      'department': instance.department,
      'documentType': instance.documentType,
      'entryTime': instance.entryTime?.toIso8601String(),
      'photoUrl': instance.photoUrl,
      'documentUrl': instance.documentUrl,
      'cabProvider': instance.cabProvider,
      'driverName': instance.driverName,
      'driverContact': instance.driverContact,
      'emergencyContactName': instance.emergencyContactName,
      'emergencyContactNumber': instance.emergencyContactNumber,
      'sendNotification': instance.sendNotification,
      'type': instance.type,
      'lastVisitId': instance.lastVisitId,
      'visitCount': instance.visitCount,
    };
