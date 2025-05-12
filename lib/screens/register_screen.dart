import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:worker_task_management_system/config/myconfig.dart'; // Make sure this is correct
import 'package:worker_task_management_system/screens/login_screen.dart'; // Ensure the import path is correct

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        color: const Color.fromARGB(255, 193, 193, 193),
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
                    const SizedBox(height: 20),
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
                  ],
                ),
              ),
            ),
          ),
        ),
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

  void _confirmRegisterUser() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    // Display a confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Register this account?"),
        content: const Text("Are you sure?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              _registerUser(); // Proceed with registration
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _registerUser() async {
    final uri = Uri.parse("${MyConfig.myurl}/php/register_worker.php");
    final response = await http.post(uri, body: {
      "name": _nameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
      "phone": _phoneController.text,
      "address": _addressController.text,
    });

    // Check if the registration was successful
    if (response.statusCode == 200) {
      print(response.body); // Debugging: Check the server response

      if (response.body == "success") {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration successful")),
        );

        // Navigate to the Login Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        // Show failure message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration failed")),
        );
      }
    } else {
      // Handle the error response
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error occurred while registering")),
      );
    }
  }
}
