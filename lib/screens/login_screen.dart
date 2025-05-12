import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/myconfig.dart';
import '../model/user.dart';
import 'profile_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void loginUser() async {
    final response = await http.post(
      Uri.parse("${MyConfig.myurl}/login_worker.php"),
      body: {
        "email": emailController.text,
        "password": passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 'success') {
        User user = User.fromJson(jsonData['data']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('userEmail', user.userEmail);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => ProfileScreen(user: user)));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Login failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: loginUser, child: const Text('Login')),
          ],
        ),
      ),
    );
  }
}
