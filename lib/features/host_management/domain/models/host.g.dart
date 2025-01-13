// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HostImpl _$$HostImplFromJson(Map<String, dynamic> json) => _$HostImpl(
      email: json['email'] as String,
      name: json['name'] as String,
      department: json['department'] as String,
      contactNumber: json['contactNumber'] as String,
      role: json['role'] as String,
      profilePhotoUrl: json['profilePhotoUrl'] as String?,
      position: json['position'] as String?,
      numberOfVisitors: (json['numberOfVisitors'] as num?)?.toInt() ?? 0,
      notificationSettings:
          json['notificationSettings'] as Map<String, dynamic>? ?? const {},
      securityLevel: json['securityLevel'] as String? ?? 'standard',
      id: json['id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      lastLogin: json['lastLogin'] == null
          ? null
          : DateTime.parse(json['lastLogin'] as String),
    );

Map<String, dynamic> _$$HostImplToJson(_$HostImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'department': instance.department,
      'contactNumber': instance.contactNumber,
      'role': instance.role,
      'profilePhotoUrl': instance.profilePhotoUrl,
      'position': instance.position,
      'numberOfVisitors': instance.numberOfVisitors,
      'notificationSettings': instance.notificationSettings,
      'securityLevel': instance.securityLevel,
    };
