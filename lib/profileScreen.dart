import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:worker_task_management_system/user.dart';
import 'package:worker_task_management_system/loginScreen.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.amber.shade900,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoTile("Worker ID", user.id),
            infoTile("Full Name", user.name),
            infoTile("Email", user.email),
            infoTile("Phone Number", user.phone),
            infoTile("Address", user.address),
          ],
        ),
      ),
    );
  }

  Widget infoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text("$title: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("user");

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }
}
