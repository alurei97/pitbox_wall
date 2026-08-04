/// Base class for all domain-layer failures.
sealed class Failure {
  const Failure(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// The API responded but with an error (5xx, unexpected body).
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Rate limited (429) — caller should back off and retry later.
class RateLimitFailure extends Failure {
  const RateLimitFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}
