import 'package:flutter/material.dart';
import 'package:worker_task_management_system/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Worker Task Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const RegisterScreen(),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 6e02cbf471cb74e4033fc5c6aeb04cedb3ee2499
