import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:surf_mad_teacher_training/api/data/error_response_dto.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/failure/failure.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/failure/network/bad_request_failure.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/failure/network/internal_server_failure.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/failure/network/network_failure.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/failure/network/no_network_failure.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/failure/network/server_not_responding_failure.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/failure/network/too_many_requests_failure.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/failure/network/unauthorized_failure.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/failure/network/unknown_network_failure.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/failure/unknown_failure.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/result/request_operation.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/result/result.dart';

typedef RequestOperationCallback<T> = RequestOperation<T> Function();

/// {@template base_repository.class}
/// Базовый класс для всех репозиториев в приложении.
/// {@endtemplate}
abstract base class BaseRepository {
  /// {@macro base_repository.class}
  const BaseRepository();

  /// Обёртка для стандартной обработки ошибок обращения к API.
  @protected
  RequestOperation<T> makeApiCall<T>(AsyncValueGetter<T> call) async {
    final Result<T, Failure> failureResult;

    try {
      final data = await call();

      return Result.ok(data);
    } on DioException catch (e, s) {
      failureResult = Result.failed(unwrapDioException(e, trace: s), s);
    } on Failure catch (e, s) {
      return Result.failed(e, s);
    } on Object catch (e, s) {
      failureResult = Result.failed(UnknownFailure(message: e.toString(), stackTrace: s), s);
    }

    if (failureResult case ResultFailed(:final error, :final stackTrace)) {
      _debugPrint(error, stackTrace);
    }

    return failureResult;
  }

  /// Маппинг ошибки API.
  @protected
  NetworkFailure unwrapDioException(DioException exception, {required StackTrace trace}) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerNotRespondingFailure();
      case DioExceptionType.sendTimeout ||
          DioExceptionType.receiveTimeout ||
          DioExceptionType.cancel ||
          DioExceptionType.connectionTimeout ||
          DioExceptionType.connectionError:
        return const NoNetworkFailure();
      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;

        ErrorResponseDto? errorResponse;
        if (exception.response?.data case final Map<String, dynamic> data) {
          try {
            errorResponse = ErrorResponseDto.fromJson(data);
          } on Object catch (e, s) {
            _debugPrint(e, s);
          }
        }

        if (statusCode == 400) {
          return BadRequestFailure(message: _getMessage(errorResponse));
        }
        if (statusCode == 429) {
          try {
            return TooManyRequestsFailure(message: _getMessage(errorResponse));
          } on Object catch (e, s) {
            _debugPrint(e, s);
          }
        }
        if (statusCode == 401) {
          return const UnauthorizedFailure();
        }
        if (statusCode == 500) {
          return const InternalServerFailure();
        }
        if (statusCode == 404) {
          return BadRequestFailure(message: _getMessage(errorResponse));
        }

      default:
        return UnknownNetworkFailure(exception);
    }

    return UnknownNetworkFailure(exception);
  }

  String? _getMessage(ErrorResponseDto? errorResponse) {
    if (errorResponse == null) {
      return null;
    }

    return '${errorResponse.error}: ${errorResponse.reasons.first}';
  }

  void _debugPrint(Object exception, [StackTrace? stackTrace]) {
    debugPrint('🔴--------exception $exception');
    debugPrint('🔴--------stackTrace ${stackTrace ?? 'null'}');
  }
}
