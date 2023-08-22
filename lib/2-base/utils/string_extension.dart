extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

extension StringNullableExtension on String? {
  bool get isNullOrEmpty => this == null || (this?.isEmpty ?? true);
}
