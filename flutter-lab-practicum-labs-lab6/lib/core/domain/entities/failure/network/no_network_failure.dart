import 'package:surf_mad_teacher_training/core/domain/entities/failure/network/network_failure.dart';

/// Ошибка, возникающая при отсутствии интернет-соединения.
final class NoNetworkFailure extends NetworkFailure {
  const NoNetworkFailure() : super(message: 'No network connection');
}
