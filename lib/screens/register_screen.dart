import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
<<<<<<< HEAD
import '../config/myconfig.dart';
import 'login_screen.dart';
=======
import 'package:worker_task_management_system/config/myconfig.dart';
import 'package:worker_task_management_system/screens/login_screen.dart';
>>>>>>> 6e02cbf471cb74e4033fc5c6aeb04cedb3ee2499

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  void _registerUser() async {
<<<<<<< HEAD
    // Validate non-empty fields before sending request
=======
    final uri = Uri.parse("${MyConfig.myurl}/register_worker.php");
    final response = await http.post(uri, body: {
      "name": _nameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
      "phone": _phoneController.text,
      "address": _addressController.text,
    });

    if (response.statusCode == 200) {
      if (response.body.trim() == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration successful")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration failed")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error occurred while registering")),
      );
    }
  }

  void _confirmRegisterUser() {
>>>>>>> 6e02cbf471cb74e4033fc5c6aeb04cedb3ee2499
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
<<<<<<< HEAD
      print("Validation failed: Some fields are empty");
      return;
    }

    try {
      print("Registering user with:");
      print("Name: ${_nameController.text.trim()}");
      print("Email: ${_emailController.text.trim()}");
      print("Phone: ${_phoneController.text.trim()}");
      print("Password: ${_passwordController.text.trim()}");
      print("Address: ${_addressController.text.trim()}");

      final uri = Uri.parse("${MyConfig.myurl}/register_worker.php");
      final response = await http.post(uri, body: {
        "name": _nameController.text.trim(),
        "email": _emailController.text.trim(),
        "password": _passwordController.text.trim(),
        "phone": _phoneController.text.trim(),
        "address": _addressController.text.trim(),
      });

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final responseBody = response.body.trim();

        if (responseBody == "success") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Registration successful")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else {
          String msg = "Registration failed";
          try {
            var jsonData = jsonDecode(responseBody);
            if (jsonData['message'] != null) {
              msg = jsonData['message'];
            }
          } catch (_) {}

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg)),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error occurred while registering")),
        );
      }
    } catch (e) {
      print("Exception caught: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Exception: $e")),
      );
    }
  }

  void _confirmRegisterUser() {
=======
      return;
    }

>>>>>>> 6e02cbf471cb74e4033fc5c6aeb04cedb3ee2499
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Register this account?"),
        content: const Text("Are you sure?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _registerUser();
            },
            child: const Text("OK"),
          ),
<<<<<<< HEAD
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
=======
>>>>>>> 6e02cbf471cb74e4033fc5c6aeb04cedb3ee2499
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    TextInputType keyboardType,
    String label, {
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscure,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEDE574), Color(0xFFE1F5C4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildTextField(_nameController, TextInputType.name, 'Full Name'),
                    _buildTextField(_emailController, TextInputType.emailAddress, 'Email'),
                    _buildTextField(_phoneController, TextInputType.phone, 'Phone Number'),
                    _buildTextField(_passwordController, TextInputType.visiblePassword, 'Password', obscure: true),
                    _buildTextField(_addressController, TextInputType.text, 'Address'),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _confirmRegisterUser,
                        child: const Text('Register'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
