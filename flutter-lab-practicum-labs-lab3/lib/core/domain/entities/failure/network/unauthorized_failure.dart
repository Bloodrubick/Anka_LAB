import 'package:surf_mad_teacher_training/core/domain/entities/failure/network/network_failure.dart';

final class UnauthorizedFailure extends NetworkFailure {
  const UnauthorizedFailure() : super(message: 'Unauthorized');
}
