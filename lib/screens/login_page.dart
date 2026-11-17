import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'project_list_screen.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/aviation_logo.png', // Your company logo
                height: 100,
              ),
              SizedBox(height: 20),
              Text(
                "Welcome to AASL",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(height: 20),
              _buildTextField("Username", Icons.person, _usernameController),
              SizedBox(height: 15),
              _buildTextField("Password", Icons.lock, _passwordController, isPassword: true),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  bool isLoggedIn = await AuthService.login(
                    _usernameController.text,
                    _passwordController.text,
                  );
                  if (isLoggedIn) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ProjectListScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Login failed. Please try again.')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Airport & Aviation Services Sri Lanka",
                style: TextStyle(
                  color: Colors.blue.shade600,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, IconData icon, TextEditingController controller, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blue.shade700),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.blue.shade400),
        filled: true,
        fillColor: Colors.blue.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(color: Colors.blue.shade900, fontSize: 16, fontFamily: 'Roboto'),
    );
  }
}
