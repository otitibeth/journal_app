import 'package:flutter/material.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({Key? key, this.noteId = ''}) : super(key: key);
  final String noteId;

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  bool get _isEditing => widget.noteId != '';
  var _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Note' : 'Add Note'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintText: 'Title',
                        hintStyle: TextStyle(
                          fontSize: 25,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _noteController,
                      decoration: const InputDecoration(
                        hintText: 'Notes',
                        border: InputBorder.none,
                      ),
                      minLines: 1,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
