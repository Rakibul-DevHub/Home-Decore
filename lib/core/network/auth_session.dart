class AuthSession {
  AuthSession._();

  static String? userId;
  static String? email;
  static String? name;
  static String? role;

  static bool get isAuthenticated => userId != null;

  static void set({
    required String userIdValue,
    String? emailValue,
    String? nameValue,
    String? roleValue,
  }) {
    userId = userIdValue;
    email = emailValue;
    name = nameValue;
    role = roleValue;
  }

  static void clear() {
    userId = null;
    email = null;
    name = null;
    role = null;
  }
}
