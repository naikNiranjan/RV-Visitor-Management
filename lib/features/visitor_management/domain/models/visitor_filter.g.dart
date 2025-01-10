// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitor_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VisitorFilterImpl _$$VisitorFilterImplFromJson(Map<String, dynamic> json) =>
    _$VisitorFilterImpl(
      department: json['department'] as String?,
      status: json['status'] as String?,
      selectedDate: json['selectedDate'] == null
          ? null
          : DateTime.parse(json['selectedDate'] as String),
      searchQuery: json['searchQuery'] as String?,
      sortBy: json['sortBy'] as String? ?? 'createdAt',
      sortAscending: json['sortAscending'] as bool? ?? false,
      visitType: json['visitType'] as String?,
      dateRange: const DateTimeRangeConverter()
          .fromJson(json['dateRange'] as Map<String, dynamic>?),
      host: json['host'] as String?,
      purpose: json['purpose'] as String?,
    );

Map<String, dynamic> _$$VisitorFilterImplToJson(_$VisitorFilterImpl instance) =>
    <String, dynamic>{
      'department': instance.department,
      'status': instance.status,
      'selectedDate': instance.selectedDate?.toIso8601String(),
      'searchQuery': instance.searchQuery,
      'sortBy': instance.sortBy,
      'sortAscending': instance.sortAscending,
      'visitType': instance.visitType,
      'dateRange': const DateTimeRangeConverter().toJson(instance.dateRange),
      'host': instance.host,
      'purpose': instance.purpose,
    };
