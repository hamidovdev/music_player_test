class ServerException implements Exception {
  final String errorMessage;
  final String errorCode;
  ServerException({
    required this.errorMessage,
    required this.errorCode,
  });

  get message => null;

  get code => null;

  @override
  String toString() =>
      'ServerException(errorMessage: $errorMessage, errorCode: $errorCode)';
}
