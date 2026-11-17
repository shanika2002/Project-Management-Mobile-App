class AuthService {
  // ✅ Hardcoded login credentials
  static const String validUsername = 'admin';
  static const String validPassword = '123456'; // Update this to your preferred password

  static Future<bool> login(String username, String password) async {
    print("🔐 Attempting manual login...");

    // Check if entered credentials match hardcoded values
    if (username.trim() == validUsername && password == validPassword) {
      print("🎉 Login successful!");
      return true;
    } else {
      print("❌ Login failed: Invalid credentials");
      return false;
    }
  }
}
