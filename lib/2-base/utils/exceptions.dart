class DefaultException implements Exception {
  final String message;

  DefaultException(this.message);
}

class InvalidFormException extends DefaultException {
  InvalidFormException() : super("Formulário inválido");
}
