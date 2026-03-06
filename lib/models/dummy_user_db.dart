class DummyUserDB {
  static List<Map<String, String>> users = [
    {
      "username": "user",
      "password": "1234",
    }
  ];

  static bool userExists(String username) {
    return users.any((user) => user["username"] == username);
  }

  static void addUser(String username, String password) {
    users.add({
      "username": username,
      "password": password,
    });
  }
}