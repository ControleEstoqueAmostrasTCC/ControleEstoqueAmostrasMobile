/// Format a brazilian date to date time datatype
DateTime formatBrazilDateToDateTime(String data) {
  final dataSplit = data.split("/");
  return DateTime(int.parse(dataSplit[2]), int.parse(dataSplit[1]), int.parse(dataSplit[0]));
}

String formatDateTimeToBrazil(DateTime data) {
  return "${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year.toString().padLeft(4, '0')}";
}

/// Convert letter to corresponding number, where a = 1, b = 2, c = 3, etc
int convertLetterToNumber(String letter) {
  final lowercaseLetter = letter.toLowerCase();
  final charCode = lowercaseLetter.codeUnitAt(0);
  final aCharCode = 'a'.codeUnitAt(0);
  return charCode - aCharCode + 1;
}

String convertNumberToLetter(int number) {
  final aCharCode = 'a'.codeUnitAt(0);
  final charCode = aCharCode + number - 1;
  return String.fromCharCode(charCode).toUpperCase();
}
