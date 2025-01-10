import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class DateTimeRangeConverter implements JsonConverter<DateTimeRange?, Map<String, dynamic>?> {
  const DateTimeRangeConverter();

  @override
  DateTimeRange? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    
    return DateTimeRange(
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
    );
  }

  @override
  Map<String, dynamic>? toJson(DateTimeRange? range) {
    if (range == null) return null;
    
    return {
      'start': range.start.toIso8601String(),
      'end': range.end.toIso8601String(),
    };
  }
} 