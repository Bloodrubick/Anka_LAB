import 'package:surf_mad_teacher_training/core/domain/entities/failure/network/network_failure.dart';

final class InternalServerFailure extends NetworkFailure {
  const InternalServerFailure() : super(message: 'Internal server error');
}
