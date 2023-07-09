import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  final String errorMessage;

  ServerFailure(this.errorMessage);
}

class CacheFailure extends Failure {
  final String errorMessage;

  CacheFailure(this.errorMessage);
}

class NetworkFailure extends Failure {
  final String errorMessage;

  NetworkFailure(this.errorMessage);
}
