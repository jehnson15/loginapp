class UserDatabase {
  static final UserDatabase _instance = UserDatabase._internal();
  final Map<String, String> _users = {};

  UserDatabase._internal();

  factory UserDatabase() {
    return _instance;
  }

  void registerUser(String email, String password) {
    _users[email] = password;
  }

  bool loginUser(String email, String password) {
    return _users[email] == password;
  }
}
