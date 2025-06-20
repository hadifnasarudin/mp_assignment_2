import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config/myconfig.dart';

class EditSubmissionScreen extends StatefulWidget {
  final String submissionId;
  final String initialText;

  const EditSubmissionScreen({
    super.key,
    required this.submissionId,
    required this.initialText,
  });

  @override
  _EditSubmissionScreenState createState() => _EditSubmissionScreenState();
}

class _EditSubmissionScreenState extends State<EditSubmissionScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = widget.initialText;
  }

  Future<void> _submitEdit() async {
    final url = Uri.parse('${MyConfig.myurl}/edit_submission.php');
    final response = await http.post(url, body: {
      'submissionId': widget.submissionId,
      'submissionDescription': _textController.text,
    });

    if (response.statusCode == 200) {
      final result = response.body;
      if (result.contains("success")) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Submission updated successfully')),
        );
        Navigator.pop(context); // go back to history screen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update submission')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Server error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Submission'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Edit Description'),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitEdit,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
