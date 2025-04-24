class Failure implements Exception{
  String message;
  Failure([this.message = 'A Random Error Occured']);

}

class InternetException extends Failure {
  InternetException([String? message]) : super(message!) ;
}


class RequestTimeOut extends Failure {
  RequestTimeOut([String? message]) : super(message!) ;
}

class ServerException extends Failure {
  ServerException([String? message]) : super(message!) ;
}

class InvalidUrlException extends Failure {
  InvalidUrlException([String? message]) : super(message!) ;
}

class FetchDataException extends Failure {
  FetchDataException([String? message]) : super(message!) ;
}

