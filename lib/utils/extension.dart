extension StringEX on String {
  /// Capitalizes the first character of the string.
  /// If the string is empty, it returns the string as is.
  String capitalizeFirst() {
    if (this.isEmpty) return this;
    return this[0].toUpperCase() + this.substring(1);
  }
}
