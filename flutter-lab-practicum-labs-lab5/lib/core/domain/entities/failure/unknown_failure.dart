import 'package:surf_mad_teacher_training/core/domain/entities/failure/failure.dart';

/// Неизвестная ошибка.
final class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message,
    super.stackTrace,
  });
}
