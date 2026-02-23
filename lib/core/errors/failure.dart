class Failure {
  final String message;

  Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});
}

class NetworkFailure extends Failure {
  NetworkFailure({required super.message});
}

class CacheFailure extends Failure {
  CacheFailure({required super.message});
}

class ValidationFailure extends Failure {
  ValidationFailure({required super.message});
}

class ModelConversionFailure extends Failure {
  ModelConversionFailure({required super.message});
}

class UnknownFailure extends Failure {
  UnknownFailure({required super.message});
}

class DioFailure extends Failure {
  DioFailure({required super.message});
}
