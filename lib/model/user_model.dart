class User {
  final int id;
  final String login;
  final String pass;

  User({this.id, this.login, this.pass});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'login': login,
      'pass': pass,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'User{id: $id, login: $login, pass: $pass}';
  }
}
