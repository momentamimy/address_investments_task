import 'package:equatable/equatable.dart';

import '../constants/text_constants.dart';

sealed class Failure extends Equatable {
  final String message;

  const Failure({required this.message});
}

class ServerFailure extends Failure {
  const ServerFailure() : super(message: TextConst.serverErrorMessage);

  @override
  List<Object?> get props => [message];
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super(message: TextConst.unknownErrorMessage);

  @override
  List<Object?> get props => [message];
}

class CustomFailure extends Failure {
  const CustomFailure({required super.message});

  @override
  List<Object?> get props => [message];
}