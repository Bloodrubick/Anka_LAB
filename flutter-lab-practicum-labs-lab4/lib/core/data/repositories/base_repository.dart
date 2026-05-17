import 'package:flutter/foundation.dart';
import 'package:surf_mad_teacher_training/core/domain/entities/failure/failure.dart';
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
  // TODO(tech-debt): на рабочих проектах используется логгер.
  void _debugPrint(Object exception, [StackTrace? stackTrace]) {
    debugPrint('🔴--------exception $exception');
    debugPrint('🔴--------stackTrace ${stackTrace ?? 'null'}');
  }
}
