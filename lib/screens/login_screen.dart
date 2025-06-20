import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/myconfig.dart';
import '../model/user.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> loginWorker() async {
    final response = await http.post(
      Uri.parse("${MyConfig.myurl}/login_worker.php"),
      body: {
        "email": _emailController.text,
        "password": _passwordController.text,
      },
    );

    try {
      final jsonData = json.decode(response.body);

      if (jsonData["status"] == "success") {
        final worker = jsonData["data"];

        final user = User(
          userId: worker["id"].toString(),
          userName: worker["name"],
          userEmail: worker["email"],
          userPhone: worker["phone"],
          userAddress: worker["address"],
        );

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', user.userId);
        await prefs.setString('userName', user.userName);
        await prefs.setString('userEmail', user.userEmail);
        await prefs.setString('userPhone', user.userPhone);
        await prefs.setString('userAddress', user.userAddress);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MainScreen(user: user)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonData["message"] ?? "Login failed")),
        );
      }
    } catch (e) {
      print("Login Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid response format")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loginWorker,
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
