import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worker_task_management_system/my_config.dart';
import 'package:worker_task_management_system/profileScreen.dart';
import 'package:worker_task_management_system/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Colors.amber.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loginUser,
              child: const Text("Login"),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // TODO: Navigate to RegisterScreen
              },
              child: const Text("Don’t have an account? Register"),
            ),
          ],
        ),
      ),
    );
  }

  void loginUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showSnack("Please fill all fields", isError: true);
      return;
    }

    var response = await http.post(
      Uri.parse("${MyConfig.myurl}/php/login_worker.php"),
      body: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      var jsondata = json.decode(response.body);
      if (jsondata['status'] == 'success') {
        var userData = jsondata['data'][0];
        User user = User.fromJson(userData);

        saveSession(user); // Save user data to SharedPreferences

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen(user: user)),
        );
      } else {
        showSnack("Login failed!", isError: true);
      }
    } else {
      showSnack("Server error", isError: true);
    }
  }

  void showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  void saveSession(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("user", jsonEncode(user.toJson()));
  }

  void autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("user")) {
      var userJson = jsonDecode(prefs.getString("user")!);
      User user = User.fromJson(userJson);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen(user: user)),
      );
    }
  }
}

