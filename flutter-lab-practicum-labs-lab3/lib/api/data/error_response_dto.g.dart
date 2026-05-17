// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponseDto _$ErrorResponseDtoFromJson(Map<String, dynamic> json) => ErrorResponseDto(
  error: json['error'] as String,
  reasons: (json['reasons'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
);

Map<String, dynamic> _$ErrorResponseDtoToJson(ErrorResponseDto instance) => <String, dynamic>{
  'error': instance.error,
  'reasons': instance.reasons,
};
