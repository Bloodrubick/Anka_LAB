import 'package:surf_mad_teacher_training/core/domain/entities/failure/network/network_failure.dart';

/// {@template timeout_exception.class}
/// TimeoutException.
/// {@endtemplate}
final class TimeoutException extends NetworkFailure {
  /// {@macro timeout_exception.class}
  const TimeoutException() : super(message: 'Timeout');
}
