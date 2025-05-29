import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'submit_completion_screen.dart';  // Make sure the path is correct!

class TaskListScreen extends StatefulWidget {
  final int workerId;

  const TaskListScreen({Key? key, required this.workerId}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final url = Uri.parse('http://10.0.2.2/wtms_api2/get_works.php?worker_id=${widget.workerId}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<dynamic> fetchedTasks = data['data'];
        setState(() {
          tasks = fetchedTasks;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load tasks')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (tasks.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Task List')),
        body: const Center(child: Text('No tasks assigned')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Task List')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            child: ListTile(
              title: Text(task['title']),
              subtitle: Text(
                'Description: ${task['description']}\n'
                'Due: ${task['due_date']}\n'
                'Status: ${task['status']}',
              ),
              isThreeLine: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubmitCompletionScreen(
                      workId: task['id'],
                      workTitle: task['title'],
                      workerId: widget.workerId,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
