import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userEmail');
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
              onPressed: () => logout(context), icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: ${user.userName}", style: const TextStyle(fontSize: 18)),
            Text("Email: ${user.userEmail}", style: const TextStyle(fontSize: 18)),
            Text("Phone: ${user.userPhone}", style: const TextStyle(fontSize: 18)),
            Text("Address: ${user.userAddress}", style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
