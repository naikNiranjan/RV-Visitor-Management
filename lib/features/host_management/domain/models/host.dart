import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'host.freezed.dart';
part 'host.g.dart';

@freezed
class Host with _$Host {
  const factory Host({
    required String email,
    required String name,
    required String department,
    required String contactNumber,
    required String role,
    String? profilePhotoUrl,
    String? position,
    @Default(0) int numberOfVisitors,
    @Default({}) Map<String, dynamic> notificationSettings,
    @Default('standard') String securityLevel,
    @JsonKey(includeFromJson: true, includeToJson: false) String? id,
    @JsonKey(includeFromJson: true, includeToJson: false) DateTime? createdAt,
    @JsonKey(includeFromJson: true, includeToJson: false) DateTime? updatedAt,
    @JsonKey(includeFromJson: true, includeToJson: false) DateTime? lastLogin,
  }) = _Host;

  factory Host.fromJson(Map<String, dynamic> json) => _$HostFromJson(json);

  factory Host.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Host.fromJson({
      ...data,
      'id': doc.id,
      'createdAt': (data['createdAt'] as Timestamp?)?.toDate(),
      'updatedAt': (data['updatedAt'] as Timestamp?)?.toDate(),
      'lastLogin': (data['lastLogin'] as Timestamp?)?.toDate(),
    });
  }
} 