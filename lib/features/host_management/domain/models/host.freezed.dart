// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'host.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Host _$HostFromJson(Map<String, dynamic> json) {
  return _Host.fromJson(json);
}

/// @nodoc
mixin _$Host {
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get department => throw _privateConstructorUsedError;
  String get contactNumber => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String? get profilePhotoUrl => throw _privateConstructorUsedError;
  String? get position => throw _privateConstructorUsedError;
  int get numberOfVisitors => throw _privateConstructorUsedError;
  Map<String, dynamic> get notificationSettings =>
      throw _privateConstructorUsedError;
  String get securityLevel => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: true, includeToJson: false)
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: true, includeToJson: false)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: true, includeToJson: false)
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: true, includeToJson: false)
  DateTime? get lastLogin => throw _privateConstructorUsedError;

  /// Serializes this Host to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Host
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HostCopyWith<Host> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HostCopyWith<$Res> {
  factory $HostCopyWith(Host value, $Res Function(Host) then) =
      _$HostCopyWithImpl<$Res, Host>;
  @useResult
  $Res call(
      {String email,
      String name,
      String department,
      String contactNumber,
      String role,
      String? profilePhotoUrl,
      String? position,
      int numberOfVisitors,
      Map<String, dynamic> notificationSettings,
      String securityLevel,
      @JsonKey(includeFromJson: true, includeToJson: false) String? id,
      @JsonKey(includeFromJson: true, includeToJson: false) DateTime? createdAt,
      @JsonKey(includeFromJson: true, includeToJson: false) DateTime? updatedAt,
      @JsonKey(includeFromJson: true, includeToJson: false)
      DateTime? lastLogin});
}

/// @nodoc
class _$HostCopyWithImpl<$Res, $Val extends Host>
    implements $HostCopyWith<$Res> {
  _$HostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Host
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? name = null,
    Object? department = null,
    Object? contactNumber = null,
    Object? role = null,
    Object? profilePhotoUrl = freezed,
    Object? position = freezed,
    Object? numberOfVisitors = null,
    Object? notificationSettings = null,
    Object? securityLevel = null,
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastLogin = freezed,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      contactNumber: null == contactNumber
          ? _value.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      profilePhotoUrl: freezed == profilePhotoUrl
          ? _value.profilePhotoUrl
          : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      numberOfVisitors: null == numberOfVisitors
          ? _value.numberOfVisitors
          : numberOfVisitors // ignore: cast_nullable_to_non_nullable
              as int,
      notificationSettings: null == notificationSettings
          ? _value.notificationSettings
          : notificationSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      securityLevel: null == securityLevel
          ? _value.securityLevel
          : securityLevel // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLogin: freezed == lastLogin
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HostImplCopyWith<$Res> implements $HostCopyWith<$Res> {
  factory _$$HostImplCopyWith(
          _$HostImpl value, $Res Function(_$HostImpl) then) =
      __$$HostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String name,
      String department,
      String contactNumber,
      String role,
      String? profilePhotoUrl,
      String? position,
      int numberOfVisitors,
      Map<String, dynamic> notificationSettings,
      String securityLevel,
      @JsonKey(includeFromJson: true, includeToJson: false) String? id,
      @JsonKey(includeFromJson: true, includeToJson: false) DateTime? createdAt,
      @JsonKey(includeFromJson: true, includeToJson: false) DateTime? updatedAt,
      @JsonKey(includeFromJson: true, includeToJson: false)
      DateTime? lastLogin});
}

/// @nodoc
class __$$HostImplCopyWithImpl<$Res>
    extends _$HostCopyWithImpl<$Res, _$HostImpl>
    implements _$$HostImplCopyWith<$Res> {
  __$$HostImplCopyWithImpl(_$HostImpl _value, $Res Function(_$HostImpl) _then)
      : super(_value, _then);

  /// Create a copy of Host
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? name = null,
    Object? department = null,
    Object? contactNumber = null,
    Object? role = null,
    Object? profilePhotoUrl = freezed,
    Object? position = freezed,
    Object? numberOfVisitors = null,
    Object? notificationSettings = null,
    Object? securityLevel = null,
    Object? id = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastLogin = freezed,
  }) {
    return _then(_$HostImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      contactNumber: null == contactNumber
          ? _value.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      profilePhotoUrl: freezed == profilePhotoUrl
          ? _value.profilePhotoUrl
          : profilePhotoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      numberOfVisitors: null == numberOfVisitors
          ? _value.numberOfVisitors
          : numberOfVisitors // ignore: cast_nullable_to_non_nullable
              as int,
      notificationSettings: null == notificationSettings
          ? _value._notificationSettings
          : notificationSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      securityLevel: null == securityLevel
          ? _value.securityLevel
          : securityLevel // ignore: cast_nullable_to_non_nullable
              as String,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLogin: freezed == lastLogin
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HostImpl implements _Host {
  const _$HostImpl(
      {required this.email,
      required this.name,
      required this.department,
      required this.contactNumber,
      required this.role,
      this.profilePhotoUrl,
      this.position,
      this.numberOfVisitors = 0,
      final Map<String, dynamic> notificationSettings = const {},
      this.securityLevel = 'standard',
      @JsonKey(includeFromJson: true, includeToJson: false) this.id,
      @JsonKey(includeFromJson: true, includeToJson: false) this.createdAt,
      @JsonKey(includeFromJson: true, includeToJson: false) this.updatedAt,
      @JsonKey(includeFromJson: true, includeToJson: false) this.lastLogin})
      : _notificationSettings = notificationSettings;

  factory _$HostImpl.fromJson(Map<String, dynamic> json) =>
      _$$HostImplFromJson(json);

  @override
  final String email;
  @override
  final String name;
  @override
  final String department;
  @override
  final String contactNumber;
  @override
  final String role;
  @override
  final String? profilePhotoUrl;
  @override
  final String? position;
  @override
  @JsonKey()
  final int numberOfVisitors;
  final Map<String, dynamic> _notificationSettings;
  @override
  @JsonKey()
  Map<String, dynamic> get notificationSettings {
    if (_notificationSettings is EqualUnmodifiableMapView)
      return _notificationSettings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_notificationSettings);
  }

  @override
  @JsonKey()
  final String securityLevel;
  @override
  @JsonKey(includeFromJson: true, includeToJson: false)
  final String? id;
  @override
  @JsonKey(includeFromJson: true, includeToJson: false)
  final DateTime? createdAt;
  @override
  @JsonKey(includeFromJson: true, includeToJson: false)
  final DateTime? updatedAt;
  @override
  @JsonKey(includeFromJson: true, includeToJson: false)
  final DateTime? lastLogin;

  @override
  String toString() {
    return 'Host(email: $email, name: $name, department: $department, contactNumber: $contactNumber, role: $role, profilePhotoUrl: $profilePhotoUrl, position: $position, numberOfVisitors: $numberOfVisitors, notificationSettings: $notificationSettings, securityLevel: $securityLevel, id: $id, createdAt: $createdAt, updatedAt: $updatedAt, lastLogin: $lastLogin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HostImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.contactNumber, contactNumber) ||
                other.contactNumber == contactNumber) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.profilePhotoUrl, profilePhotoUrl) ||
                other.profilePhotoUrl == profilePhotoUrl) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.numberOfVisitors, numberOfVisitors) ||
                other.numberOfVisitors == numberOfVisitors) &&
            const DeepCollectionEquality()
                .equals(other._notificationSettings, _notificationSettings) &&
            (identical(other.securityLevel, securityLevel) ||
                other.securityLevel == securityLevel) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastLogin, lastLogin) ||
                other.lastLogin == lastLogin));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      email,
      name,
      department,
      contactNumber,
      role,
      profilePhotoUrl,
      position,
      numberOfVisitors,
      const DeepCollectionEquality().hash(_notificationSettings),
      securityLevel,
      id,
      createdAt,
      updatedAt,
      lastLogin);

  /// Create a copy of Host
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HostImplCopyWith<_$HostImpl> get copyWith =>
      __$$HostImplCopyWithImpl<_$HostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HostImplToJson(
      this,
    );
  }
}

abstract class _Host implements Host {
  const factory _Host(
      {required final String email,
      required final String name,
      required final String department,
      required final String contactNumber,
      required final String role,
      final String? profilePhotoUrl,
      final String? position,
      final int numberOfVisitors,
      final Map<String, dynamic> notificationSettings,
      final String securityLevel,
      @JsonKey(includeFromJson: true, includeToJson: false) final String? id,
      @JsonKey(includeFromJson: true, includeToJson: false)
      final DateTime? createdAt,
      @JsonKey(includeFromJson: true, includeToJson: false)
      final DateTime? updatedAt,
      @JsonKey(includeFromJson: true, includeToJson: false)
      final DateTime? lastLogin}) = _$HostImpl;

  factory _Host.fromJson(Map<String, dynamic> json) = _$HostImpl.fromJson;

  @override
  String get email;
  @override
  String get name;
  @override
  String get department;
  @override
  String get contactNumber;
  @override
  String get role;
  @override
  String? get profilePhotoUrl;
  @override
  String? get position;
  @override
  int get numberOfVisitors;
  @override
  Map<String, dynamic> get notificationSettings;
  @override
  String get securityLevel;
  @override
  @JsonKey(includeFromJson: true, includeToJson: false)
  String? get id;
  @override
  @JsonKey(includeFromJson: true, includeToJson: false)
  DateTime? get createdAt;
  @override
  @JsonKey(includeFromJson: true, includeToJson: false)
  DateTime? get updatedAt;
  @override
  @JsonKey(includeFromJson: true, includeToJson: false)
  DateTime? get lastLogin;

  /// Create a copy of Host
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HostImplCopyWith<_$HostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
