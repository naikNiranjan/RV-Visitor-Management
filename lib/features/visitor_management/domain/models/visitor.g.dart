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
      photoUrl: json['photoUrl'] as String?,
      numberOfVisitors: (json['numberOfVisitors'] as num).toInt(),
      whomToMeet: json['whomToMeet'] as String,
      department: json['department'] as String,
      documentType: json['documentType'] as String,
      documentUrl: json['documentUrl'] as String?,
      emergencyContactName: json['emergencyContactName'] as String?,
      emergencyContactNumber: json['emergencyContactNumber'] as String?,
      cabProvider: json['cabProvider'] as String?,
      driverName: json['driverName'] as String?,
      driverContact: json['driverContact'] as String?,
      sendNotification: json['sendNotification'] as bool? ?? false,
      isApproved: json['isApproved'] as bool? ?? false,
      entryTime: json['entryTime'] == null
          ? null
          : DateTime.parse(json['entryTime'] as String),
      exitTime: json['exitTime'] == null
          ? null
          : DateTime.parse(json['exitTime'] as String),
    );

Map<String, dynamic> _$$VisitorImplToJson(_$VisitorImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'contactNumber': instance.contactNumber,
      'email': instance.email,
      'vehicleNumber': instance.vehicleNumber,
      'purposeOfVisit': instance.purposeOfVisit,
      'photoUrl': instance.photoUrl,
      'numberOfVisitors': instance.numberOfVisitors,
      'whomToMeet': instance.whomToMeet,
      'department': instance.department,
      'documentType': instance.documentType,
      'documentUrl': instance.documentUrl,
      'emergencyContactName': instance.emergencyContactName,
      'emergencyContactNumber': instance.emergencyContactNumber,
      'cabProvider': instance.cabProvider,
      'driverName': instance.driverName,
      'driverContact': instance.driverContact,
      'sendNotification': instance.sendNotification,
      'isApproved': instance.isApproved,
      'entryTime': instance.entryTime?.toIso8601String(),
      'exitTime': instance.exitTime?.toIso8601String(),
    };
