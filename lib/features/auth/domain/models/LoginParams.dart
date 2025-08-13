class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password}) {
    if (email.trim().isEmpty && password.trim().isEmpty) {
      throw Exception('Fill All Fields');
    } else if (email.trim().isEmpty || !email.contains('@')) {
      throw Exception('Invalid Email');
    }
    if (password.trim().length < 4) {
      throw Exception('Password must be at least 5 characters long');
    }
  }
}
