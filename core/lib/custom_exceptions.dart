library core;

class CustomException implements Exception {
  final String _message;
  final String _prefix;

  CustomException(this._message, this._prefix);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException(String message) : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException(String message) : super(message, "Invalid Input: ");
}

class InternalServerException extends CustomException {
  InternalServerException(String message) : super(message, "Internal Server Error: ");
}

class ApiErrorException extends CustomException {
  ApiErrorException(String errorMessage) : super(errorMessage, "");
}

class ApiTokenExpiredException extends CustomException {
  ApiTokenExpiredException(String errorMessage) : super(errorMessage, "");
}

class NoInternetException extends CustomException {
  NoInternetException(String errorMessage) : super(errorMessage, "");
}

class DataNotFoundException extends CustomException {
  DataNotFoundException(String errorMessage) : super(errorMessage, "");
}
