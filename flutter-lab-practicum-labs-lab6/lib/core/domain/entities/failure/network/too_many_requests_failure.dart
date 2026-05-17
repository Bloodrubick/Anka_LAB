import 'package:surf_mad_teacher_training/core/domain/entities/failure/network/network_failure.dart';

final class TooManyRequestsFailure extends NetworkFailure {
  const TooManyRequestsFailure({
    super.message,
    super.parentException,
    super.stackTrace,
  });
}
