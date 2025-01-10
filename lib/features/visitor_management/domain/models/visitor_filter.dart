import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/date_time_range_converter.dart';

part 'visitor_filter.freezed.dart';
part 'visitor_filter.g.dart';

@freezed
class VisitorFilter with _$VisitorFilter {
  const factory VisitorFilter({
    String? department,
    String? status,
    DateTime? selectedDate,
    String? searchQuery,
    @Default('createdAt') String sortBy,
    @Default(false) bool sortAscending,
    String? visitType,
    @DateTimeRangeConverter() 
    DateTimeRange? dateRange,
    String? host,
    String? purpose,
  }) = _VisitorFilter;

  factory VisitorFilter.fromJson(Map<String, dynamic> json) => 
      _$VisitorFilterFromJson(json);
} 