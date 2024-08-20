class SignupWithEmailAndPasswordFailure {
  final String message;

  const SignupWithEmailAndPasswordFailure(
      [this.message = "An Unknown Error Occurred. Please Try Again."]);

  factory SignupWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case "invalid-email":
        return const SignupWithEmailAndPasswordFailure(
            "Invalid Email Address.");
      case "user-disabled":
        return const SignupWithEmailAndPasswordFailure(
            "The user account has been disabled.");
      case "user-not-found":
        return const SignupWithEmailAndPasswordFailure(
            "There is no user record corresponding to this email.");
      case "wrong-password":
        return const SignupWithEmailAndPasswordFailure(
            "The password is invalid or the user account has been disabled.");
      case "email-already-in-use":
        return const SignupWithEmailAndPasswordFailure(
            "The email address is already in use by another account.");
      case "weak-password":
        return const SignupWithEmailAndPasswordFailure(
            "The password is not strong enough.");
      case "operation-not-allowed":
        return const SignupWithEmailAndPasswordFailure(
            "Email sign-in is not enabled for this project.");
      case "account-exists-with-different-credential":
        return const SignupWithEmailAndPasswordFailure(
            "An account already exists with the same email address but different sign-in credentials.");
      case "invalid-credential":
        return const SignupWithEmailAndPasswordFailure(
            "The credential is malformed or has expired.");
      case "invalid-verification-code":
        return const SignupWithEmailAndPasswordFailure(
            "The verification code entered is invalid.");
      case "invalid-verification-id":
        return const SignupWithEmailAndPasswordFailure(
            "The verification ID entered is invalid.");
      case "timeout":
        return const SignupWithEmailAndPasswordFailure(
            "The network operation timed out.");
      case "captcha-check-failed":
        return const SignupWithEmailAndPasswordFailure(
            "The captcha check failed.");
      default:
        return const SignupWithEmailAndPasswordFailure();
    }
  }
}
