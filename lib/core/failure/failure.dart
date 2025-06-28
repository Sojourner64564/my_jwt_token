abstract class Failure {}

class NoInternetFailure extends Failure {}

class InvalidEmailFailure extends Failure {}

class ExpiredEmailCodeFailure extends Failure {}

class ServerFailure extends Failure {}

class AppFailure extends Failure {}
