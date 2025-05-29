import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';
import 'login_screen.dart';
<<<<<<< HEAD
import 'task_list_screen.dart';  // <-- Make sure this file exists and is imported
=======
>>>>>>> 6e02cbf471cb74e4033fc5c6aeb04cedb3ee2499

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
<<<<<<< HEAD
    await prefs.clear(); // safer than just removing one key
=======
    prefs.remove('userEmail');
>>>>>>> 6e02cbf471cb74e4033fc5c6aeb04cedb3ee2499
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

<<<<<<< HEAD
  void viewTasks(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TaskListScreen(workerId: int.parse(user.userId)),
      ),
    );
  }

=======
>>>>>>> 6e02cbf471cb74e4033fc5c6aeb04cedb3ee2499
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () => logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFF9C4), Color(0xFFFFECB3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
<<<<<<< HEAD
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Icon(Icons.account_circle, size: 80, color: Colors.orange),
                      ),
                      const SizedBox(height: 20),
                      Text("Name: ${user.userName}",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text("Worker ID: ${user.userId}",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 10),
                      Text("Email: ${user.userEmail}", style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      Text("Phone: ${user.userPhone}", style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      Text("Address: ${user.userAddress}", style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => viewTasks(context),
                  child: const Text('View Tasks'),
                ),
              ),
            ],
=======
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Icon(Icons.account_circle, size: 80, color: Colors.orange),
                  ),
                  const SizedBox(height: 20),
                  Text("Name: ${user.userName}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text("Worker ID: ${user.userId}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10),
                  Text("Email: ${user.userEmail}",
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Text("Phone: ${user.userPhone}",
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),
                  Text("Address: ${user.userAddress}",
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
>>>>>>> 6e02cbf471cb74e4033fc5c6aeb04cedb3ee2499
          ),
        ),
      ),
    );
  }
}
