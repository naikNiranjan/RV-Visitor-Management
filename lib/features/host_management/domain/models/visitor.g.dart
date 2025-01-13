// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VisitorImpl _$$VisitorImplFromJson(Map<String, dynamic> json) =>
    _$VisitorImpl(
      id: json['id'] as String?,
      name: json['name'] as String,
      email: json['email'] as String,
      contactNumber: json['contactNumber'] as String,
      purposeOfVisit: json['purposeOfVisit'] as String,
      department: json['department'] as String,
      photoUrl: json['photoUrl'] as String?,
      status: json['status'] as String? ?? 'pending',
      entryTime: json['entryTime'] == null
          ? null
          : DateTime.parse(json['entryTime'] as String),
      exitTime: json['exitTime'] == null
          ? null
          : DateTime.parse(json['exitTime'] as String),
    );

Map<String, dynamic> _$$VisitorImplToJson(_$VisitorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'contactNumber': instance.contactNumber,
      'purposeOfVisit': instance.purposeOfVisit,
      'department': instance.department,
      'photoUrl': instance.photoUrl,
      'status': instance.status,
      'entryTime': instance.entryTime?.toIso8601String(),
      'exitTime': instance.exitTime?.toIso8601String(),
    };
