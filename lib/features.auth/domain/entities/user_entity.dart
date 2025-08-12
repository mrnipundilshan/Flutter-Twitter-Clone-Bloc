class UserEntity {
  final String email;
  final String username;
  final String password;

  UserEntity({
    required this.email,
    required this.username,
    required this.password,
  }) {
    if (email.trim().isEmpty || !email.contains('@')) {
      throw Exception('Invalid email');
    }
  }
}
