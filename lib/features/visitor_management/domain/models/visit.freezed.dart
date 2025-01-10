// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'visit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Visit _$VisitFromJson(Map<String, dynamic> json) {
  return _Visit.fromJson(json);
}

/// @nodoc
mixin _$Visit {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get contactNumber => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String get department => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // pending, checked_in, checked_out
  String get type =>
      throw _privateConstructorUsedError; // registration, quick_checkin, cab
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get entryTime => throw _privateConstructorUsedError;
  DateTime? get exitTime => throw _privateConstructorUsedError;
  String get whomToMeet => throw _privateConstructorUsedError;
  String get whomToMeetEmail => throw _privateConstructorUsedError;
  String get purposeOfVisit => throw _privateConstructorUsedError;
  int? get numberOfVisitors => throw _privateConstructorUsedError;
  String? get vehicleNumber => throw _privateConstructorUsedError;
  String? get documentType => throw _privateConstructorUsedError;
  bool? get hasDocument => throw _privateConstructorUsedError;
  bool? get hasPhoto => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;
  String? get documentUrl => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get remarks => throw _privateConstructorUsedError;
  bool? get isApproved => throw _privateConstructorUsedError;
  String? get approvedBy => throw _privateConstructorUsedError;
  DateTime? get approvedAt => throw _privateConstructorUsedError;
  bool? get sendNotification => throw _privateConstructorUsedError;
  bool? get notificationSent => throw _privateConstructorUsedError;
  DateTime? get notificationSentAt =>
      throw _privateConstructorUsedError; // Cab specific fields
  String? get cabProvider => throw _privateConstructorUsedError;
  String? get driverName => throw _privateConstructorUsedError;
  String? get driverContact => throw _privateConstructorUsedError;

  /// Serializes this Visit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Visit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VisitCopyWith<Visit> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VisitCopyWith<$Res> {
  factory $VisitCopyWith(Visit value, $Res Function(Visit) then) =
      _$VisitCopyWithImpl<$Res, Visit>;
  @useResult
  $Res call(
      {String id,
      String name,
      String contactNumber,
      String? email,
      String department,
      String status,
      String type,
      DateTime createdAt,
      DateTime entryTime,
      DateTime? exitTime,
      String whomToMeet,
      String whomToMeetEmail,
      String purposeOfVisit,
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
      String? cabProvider,
      String? driverName,
      String? driverContact});
}

/// @nodoc
class _$VisitCopyWithImpl<$Res, $Val extends Visit>
    implements $VisitCopyWith<$Res> {
  _$VisitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Visit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? contactNumber = null,
    Object? email = freezed,
    Object? department = null,
    Object? status = null,
    Object? type = null,
    Object? createdAt = null,
    Object? entryTime = null,
    Object? exitTime = freezed,
    Object? whomToMeet = null,
    Object? whomToMeetEmail = null,
    Object? purposeOfVisit = null,
    Object? numberOfVisitors = freezed,
    Object? vehicleNumber = freezed,
    Object? documentType = freezed,
    Object? hasDocument = freezed,
    Object? hasPhoto = freezed,
    Object? photoUrl = freezed,
    Object? documentUrl = freezed,
    Object? address = freezed,
    Object? remarks = freezed,
    Object? isApproved = freezed,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
    Object? sendNotification = freezed,
    Object? notificationSent = freezed,
    Object? notificationSentAt = freezed,
    Object? cabProvider = freezed,
    Object? driverName = freezed,
    Object? driverContact = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      contactNumber: null == contactNumber
          ? _value.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      entryTime: null == entryTime
          ? _value.entryTime
          : entryTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      exitTime: freezed == exitTime
          ? _value.exitTime
          : exitTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      whomToMeet: null == whomToMeet
          ? _value.whomToMeet
          : whomToMeet // ignore: cast_nullable_to_non_nullable
              as String,
      whomToMeetEmail: null == whomToMeetEmail
          ? _value.whomToMeetEmail
          : whomToMeetEmail // ignore: cast_nullable_to_non_nullable
              as String,
      purposeOfVisit: null == purposeOfVisit
          ? _value.purposeOfVisit
          : purposeOfVisit // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfVisitors: freezed == numberOfVisitors
          ? _value.numberOfVisitors
          : numberOfVisitors // ignore: cast_nullable_to_non_nullable
              as int?,
      vehicleNumber: freezed == vehicleNumber
          ? _value.vehicleNumber
          : vehicleNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      documentType: freezed == documentType
          ? _value.documentType
          : documentType // ignore: cast_nullable_to_non_nullable
              as String?,
      hasDocument: freezed == hasDocument
          ? _value.hasDocument
          : hasDocument // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasPhoto: freezed == hasPhoto
          ? _value.hasPhoto
          : hasPhoto // ignore: cast_nullable_to_non_nullable
              as bool?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      documentUrl: freezed == documentUrl
          ? _value.documentUrl
          : documentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      remarks: freezed == remarks
          ? _value.remarks
          : remarks // ignore: cast_nullable_to_non_nullable
              as String?,
      isApproved: freezed == isApproved
          ? _value.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sendNotification: freezed == sendNotification
          ? _value.sendNotification
          : sendNotification // ignore: cast_nullable_to_non_nullable
              as bool?,
      notificationSent: freezed == notificationSent
          ? _value.notificationSent
          : notificationSent // ignore: cast_nullable_to_non_nullable
              as bool?,
      notificationSentAt: freezed == notificationSentAt
          ? _value.notificationSentAt
          : notificationSentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cabProvider: freezed == cabProvider
          ? _value.cabProvider
          : cabProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      driverName: freezed == driverName
          ? _value.driverName
          : driverName // ignore: cast_nullable_to_non_nullable
              as String?,
      driverContact: freezed == driverContact
          ? _value.driverContact
          : driverContact // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VisitImplCopyWith<$Res> implements $VisitCopyWith<$Res> {
  factory _$$VisitImplCopyWith(
          _$VisitImpl value, $Res Function(_$VisitImpl) then) =
      __$$VisitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String contactNumber,
      String? email,
      String department,
      String status,
      String type,
      DateTime createdAt,
      DateTime entryTime,
      DateTime? exitTime,
      String whomToMeet,
      String whomToMeetEmail,
      String purposeOfVisit,
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
      String? cabProvider,
      String? driverName,
      String? driverContact});
}

/// @nodoc
class __$$VisitImplCopyWithImpl<$Res>
    extends _$VisitCopyWithImpl<$Res, _$VisitImpl>
    implements _$$VisitImplCopyWith<$Res> {
  __$$VisitImplCopyWithImpl(
      _$VisitImpl _value, $Res Function(_$VisitImpl) _then)
      : super(_value, _then);

  /// Create a copy of Visit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? contactNumber = null,
    Object? email = freezed,
    Object? department = null,
    Object? status = null,
    Object? type = null,
    Object? createdAt = null,
    Object? entryTime = null,
    Object? exitTime = freezed,
    Object? whomToMeet = null,
    Object? whomToMeetEmail = null,
    Object? purposeOfVisit = null,
    Object? numberOfVisitors = freezed,
    Object? vehicleNumber = freezed,
    Object? documentType = freezed,
    Object? hasDocument = freezed,
    Object? hasPhoto = freezed,
    Object? photoUrl = freezed,
    Object? documentUrl = freezed,
    Object? address = freezed,
    Object? remarks = freezed,
    Object? isApproved = freezed,
    Object? approvedBy = freezed,
    Object? approvedAt = freezed,
    Object? sendNotification = freezed,
    Object? notificationSent = freezed,
    Object? notificationSentAt = freezed,
    Object? cabProvider = freezed,
    Object? driverName = freezed,
    Object? driverContact = freezed,
  }) {
    return _then(_$VisitImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      contactNumber: null == contactNumber
          ? _value.contactNumber
          : contactNumber // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      entryTime: null == entryTime
          ? _value.entryTime
          : entryTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      exitTime: freezed == exitTime
          ? _value.exitTime
          : exitTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      whomToMeet: null == whomToMeet
          ? _value.whomToMeet
          : whomToMeet // ignore: cast_nullable_to_non_nullable
              as String,
      whomToMeetEmail: null == whomToMeetEmail
          ? _value.whomToMeetEmail
          : whomToMeetEmail // ignore: cast_nullable_to_non_nullable
              as String,
      purposeOfVisit: null == purposeOfVisit
          ? _value.purposeOfVisit
          : purposeOfVisit // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfVisitors: freezed == numberOfVisitors
          ? _value.numberOfVisitors
          : numberOfVisitors // ignore: cast_nullable_to_non_nullable
              as int?,
      vehicleNumber: freezed == vehicleNumber
          ? _value.vehicleNumber
          : vehicleNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      documentType: freezed == documentType
          ? _value.documentType
          : documentType // ignore: cast_nullable_to_non_nullable
              as String?,
      hasDocument: freezed == hasDocument
          ? _value.hasDocument
          : hasDocument // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasPhoto: freezed == hasPhoto
          ? _value.hasPhoto
          : hasPhoto // ignore: cast_nullable_to_non_nullable
              as bool?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      documentUrl: freezed == documentUrl
          ? _value.documentUrl
          : documentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      remarks: freezed == remarks
          ? _value.remarks
          : remarks // ignore: cast_nullable_to_non_nullable
              as String?,
      isApproved: freezed == isApproved
          ? _value.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool?,
      approvedBy: freezed == approvedBy
          ? _value.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedAt: freezed == approvedAt
          ? _value.approvedAt
          : approvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sendNotification: freezed == sendNotification
          ? _value.sendNotification
          : sendNotification // ignore: cast_nullable_to_non_nullable
              as bool?,
      notificationSent: freezed == notificationSent
          ? _value.notificationSent
          : notificationSent // ignore: cast_nullable_to_non_nullable
              as bool?,
      notificationSentAt: freezed == notificationSentAt
          ? _value.notificationSentAt
          : notificationSentAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cabProvider: freezed == cabProvider
          ? _value.cabProvider
          : cabProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      driverName: freezed == driverName
          ? _value.driverName
          : driverName // ignore: cast_nullable_to_non_nullable
              as String?,
      driverContact: freezed == driverContact
          ? _value.driverContact
          : driverContact // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VisitImpl implements _Visit {
  const _$VisitImpl(
      {required this.id,
      required this.name,
      required this.contactNumber,
      this.email,
      required this.department,
      required this.status,
      required this.type,
      required this.createdAt,
      required this.entryTime,
      this.exitTime,
      required this.whomToMeet,
      required this.whomToMeetEmail,
      required this.purposeOfVisit,
      this.numberOfVisitors,
      this.vehicleNumber,
      this.documentType,
      this.hasDocument,
      this.hasPhoto,
      this.photoUrl,
      this.documentUrl,
      this.address,
      this.remarks,
      this.isApproved,
      this.approvedBy,
      this.approvedAt,
      this.sendNotification,
      this.notificationSent,
      this.notificationSentAt,
      this.cabProvider,
      this.driverName,
      this.driverContact});

  factory _$VisitImpl.fromJson(Map<String, dynamic> json) =>
      _$$VisitImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String contactNumber;
  @override
  final String? email;
  @override
  final String department;
  @override
  final String status;
// pending, checked_in, checked_out
  @override
  final String type;
// registration, quick_checkin, cab
  @override
  final DateTime createdAt;
  @override
  final DateTime entryTime;
  @override
  final DateTime? exitTime;
  @override
  final String whomToMeet;
  @override
  final String whomToMeetEmail;
  @override
  final String purposeOfVisit;
  @override
  final int? numberOfVisitors;
  @override
  final String? vehicleNumber;
  @override
  final String? documentType;
  @override
  final bool? hasDocument;
  @override
  final bool? hasPhoto;
  @override
  final String? photoUrl;
  @override
  final String? documentUrl;
  @override
  final String? address;
  @override
  final String? remarks;
  @override
  final bool? isApproved;
  @override
  final String? approvedBy;
  @override
  final DateTime? approvedAt;
  @override
  final bool? sendNotification;
  @override
  final bool? notificationSent;
  @override
  final DateTime? notificationSentAt;
// Cab specific fields
  @override
  final String? cabProvider;
  @override
  final String? driverName;
  @override
  final String? driverContact;

  @override
  String toString() {
    return 'Visit(id: $id, name: $name, contactNumber: $contactNumber, email: $email, department: $department, status: $status, type: $type, createdAt: $createdAt, entryTime: $entryTime, exitTime: $exitTime, whomToMeet: $whomToMeet, whomToMeetEmail: $whomToMeetEmail, purposeOfVisit: $purposeOfVisit, numberOfVisitors: $numberOfVisitors, vehicleNumber: $vehicleNumber, documentType: $documentType, hasDocument: $hasDocument, hasPhoto: $hasPhoto, photoUrl: $photoUrl, documentUrl: $documentUrl, address: $address, remarks: $remarks, isApproved: $isApproved, approvedBy: $approvedBy, approvedAt: $approvedAt, sendNotification: $sendNotification, notificationSent: $notificationSent, notificationSentAt: $notificationSentAt, cabProvider: $cabProvider, driverName: $driverName, driverContact: $driverContact)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VisitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.contactNumber, contactNumber) ||
                other.contactNumber == contactNumber) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.entryTime, entryTime) ||
                other.entryTime == entryTime) &&
            (identical(other.exitTime, exitTime) ||
                other.exitTime == exitTime) &&
            (identical(other.whomToMeet, whomToMeet) ||
                other.whomToMeet == whomToMeet) &&
            (identical(other.whomToMeetEmail, whomToMeetEmail) ||
                other.whomToMeetEmail == whomToMeetEmail) &&
            (identical(other.purposeOfVisit, purposeOfVisit) ||
                other.purposeOfVisit == purposeOfVisit) &&
            (identical(other.numberOfVisitors, numberOfVisitors) ||
                other.numberOfVisitors == numberOfVisitors) &&
            (identical(other.vehicleNumber, vehicleNumber) ||
                other.vehicleNumber == vehicleNumber) &&
            (identical(other.documentType, documentType) ||
                other.documentType == documentType) &&
            (identical(other.hasDocument, hasDocument) ||
                other.hasDocument == hasDocument) &&
            (identical(other.hasPhoto, hasPhoto) ||
                other.hasPhoto == hasPhoto) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.documentUrl, documentUrl) ||
                other.documentUrl == documentUrl) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.remarks, remarks) || other.remarks == remarks) &&
            (identical(other.isApproved, isApproved) ||
                other.isApproved == isApproved) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.approvedAt, approvedAt) ||
                other.approvedAt == approvedAt) &&
            (identical(other.sendNotification, sendNotification) ||
                other.sendNotification == sendNotification) &&
            (identical(other.notificationSent, notificationSent) ||
                other.notificationSent == notificationSent) &&
            (identical(other.notificationSentAt, notificationSentAt) ||
                other.notificationSentAt == notificationSentAt) &&
            (identical(other.cabProvider, cabProvider) ||
                other.cabProvider == cabProvider) &&
            (identical(other.driverName, driverName) ||
                other.driverName == driverName) &&
            (identical(other.driverContact, driverContact) ||
                other.driverContact == driverContact));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        contactNumber,
        email,
        department,
        status,
        type,
        createdAt,
        entryTime,
        exitTime,
        whomToMeet,
        whomToMeetEmail,
        purposeOfVisit,
        numberOfVisitors,
        vehicleNumber,
        documentType,
        hasDocument,
        hasPhoto,
        photoUrl,
        documentUrl,
        address,
        remarks,
        isApproved,
        approvedBy,
        approvedAt,
        sendNotification,
        notificationSent,
        notificationSentAt,
        cabProvider,
        driverName,
        driverContact
      ]);

  /// Create a copy of Visit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VisitImplCopyWith<_$VisitImpl> get copyWith =>
      __$$VisitImplCopyWithImpl<_$VisitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VisitImplToJson(
      this,
    );
  }
}

abstract class _Visit implements Visit {
  const factory _Visit(
      {required final String id,
      required final String name,
      required final String contactNumber,
      final String? email,
      required final String department,
      required final String status,
      required final String type,
      required final DateTime createdAt,
      required final DateTime entryTime,
      final DateTime? exitTime,
      required final String whomToMeet,
      required final String whomToMeetEmail,
      required final String purposeOfVisit,
      final int? numberOfVisitors,
      final String? vehicleNumber,
      final String? documentType,
      final bool? hasDocument,
      final bool? hasPhoto,
      final String? photoUrl,
      final String? documentUrl,
      final String? address,
      final String? remarks,
      final bool? isApproved,
      final String? approvedBy,
      final DateTime? approvedAt,
      final bool? sendNotification,
      final bool? notificationSent,
      final DateTime? notificationSentAt,
      final String? cabProvider,
      final String? driverName,
      final String? driverContact}) = _$VisitImpl;

  factory _Visit.fromJson(Map<String, dynamic> json) = _$VisitImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get contactNumber;
  @override
  String? get email;
  @override
  String get department;
  @override
  String get status; // pending, checked_in, checked_out
  @override
  String get type; // registration, quick_checkin, cab
  @override
  DateTime get createdAt;
  @override
  DateTime get entryTime;
  @override
  DateTime? get exitTime;
  @override
  String get whomToMeet;
  @override
  String get whomToMeetEmail;
  @override
  String get purposeOfVisit;
  @override
  int? get numberOfVisitors;
  @override
  String? get vehicleNumber;
  @override
  String? get documentType;
  @override
  bool? get hasDocument;
  @override
  bool? get hasPhoto;
  @override
  String? get photoUrl;
  @override
  String? get documentUrl;
  @override
  String? get address;
  @override
  String? get remarks;
  @override
  bool? get isApproved;
  @override
  String? get approvedBy;
  @override
  DateTime? get approvedAt;
  @override
  bool? get sendNotification;
  @override
  bool? get notificationSent;
  @override
  DateTime? get notificationSentAt; // Cab specific fields
  @override
  String? get cabProvider;
  @override
  String? get driverName;
  @override
  String? get driverContact;

  /// Create a copy of Visit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VisitImplCopyWith<_$VisitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
