import 'package:surf_mad_teacher_training/core/domain/entities/failure/network/network_failure.dart';

final class ServerNotRespondingFailure extends NetworkFailure {
  const ServerNotRespondingFailure() : super(message: 'Server not responding');
}
