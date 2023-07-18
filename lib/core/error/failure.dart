import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMessage;

  Failure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

// General failures
class ServerFailure extends Failure {
  ServerFailure(String errorMessage) : super(errorMessage);
}

class CacheFailure extends Failure {
  CacheFailure(String errorMessage) : super(errorMessage);
}

class NetworkFailure extends Failure {
  NetworkFailure(String errorMessage) : super(errorMessage);
}
