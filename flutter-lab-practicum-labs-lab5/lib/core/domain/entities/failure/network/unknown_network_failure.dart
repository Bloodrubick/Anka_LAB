import 'package:surf_mad_teacher_training/core/domain/entities/failure/network/network_failure.dart';

final class UnknownNetworkFailure extends NetworkFailure {
  const UnknownNetworkFailure(Exception exception) : super(parentException: exception);
}
