import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class SubmitCompletionScreen extends StatefulWidget {
  final int workerId;
  final int workId;
  final String workTitle;

  SubmitCompletionScreen({
    required this.workerId,
    required this.workId,
    required this.workTitle,
  });

  @override
  _SubmitCompletionScreenState createState() => _SubmitCompletionScreenState();
}

class _SubmitCompletionScreenState extends State<SubmitCompletionScreen> {
  final _controller = TextEditingController();
  bool _isSubmitting = false;
  String? _message;

  Future<void> submitReport() async {
    if (_controller.text.isEmpty) {
      setState(() {
        _message = 'Please enter completion details.';
      });
      return;
    }

    setState(() {
      _isSubmitting = true;
      _message = null;
    });

    final response = await http.post(
      Uri.parse('http://10.0.2.2/wtms_api2/submit_work.php'),
      body: {
        'work_id': widget.workId.toString(),
        'worker_id': widget.workerId.toString(),
        'submission_text': _controller.text,
      }
    );

    if (response.statusCode == 200) {
      final res = json.decode(response.body);
      if (res['status'] == 'success') {
        setState(() {
          _message = 'Submission successful!';
        });
      } else {
        setState(() {
          _message = 'Submission failed: ${res['message']}';
        });
      }
    } else {
      setState(() {
        _message = 'Server error, try again later.';
      });
    }

    setState(() {
      _isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Submit Completion')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Task: ${widget.workTitle}', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'What did you complete?',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            _isSubmitting
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: submitReport,
                  child: Text('Submit'),
                ),
            if (_message != null) ...[
              SizedBox(height: 20),
              Text(_message!, style: TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
    );
  }
}
