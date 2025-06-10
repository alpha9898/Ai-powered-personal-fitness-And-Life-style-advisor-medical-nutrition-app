class Custom_Exaption implements Exception {
  String message;

  Custom_Exaption({required this.message});

  @override
  String toString() {
    return message;
  }
}
