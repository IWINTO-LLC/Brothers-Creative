class TFirebaseAuthException implements Exception {
  final String code;
  TFirebaseAuthException(this.code);

  String get message {
    switch (code) {
      case 'dswf':
        return 'dswf';
      case 'dsf':
        return 'dswf';
      case 'df':
        return 'dswf';

      default:
        return 'An Exception Firebase error .Please try again latger';
    }
  }
}
