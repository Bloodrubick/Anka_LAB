import 'package:json_annotation/json_annotation.dart';

part 'error_response_dto.g.dart';

/// Содержит себе всю информацию о произошедшей в логике на сервере ошибке.
@JsonSerializable(includeIfNull: false)
class ErrorResponseDto {
  /// Ошибка.
  final String error;

  /// Причины.
  final List<String> reasons;

  const ErrorResponseDto({required this.error, this.reasons = const []});

  /// From Json.
  factory ErrorResponseDto.fromJson(Map<String, dynamic> json) => _$ErrorResponseDtoFromJson(json);

  /// To Json.
  Map<String, dynamic> toJson() => _$ErrorResponseDtoToJson(this);
}
