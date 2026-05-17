import 'package:surf_mad_teacher_training/core/domain/entities/failure/failure.dart';

abstract class NetworkFailure extends Failure {
  const NetworkFailure({super.message, super.parentException, super.stackTrace});
}
