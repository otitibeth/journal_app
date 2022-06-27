import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_journal/models/note_model.dart';
import 'package:my_journal/resources/firebase_database_methods.dart';
import 'package:my_journal/screens/notelist_screen.dart';
import 'package:my_journal/screens/theme_screen.dart';
import 'package:my_journal/utils/utils.dart';
import 'package:provider/provider.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({Key? key, required this.noteId}) : super(key: key);
  final String noteId;

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  bool get _isEditing => widget.noteId != '';
  var _isLoading = false;
  var _isInit = false;

  var _initValues = {
    'title': '',
    'content': '',
  };

  final userId = FirebaseAuth.instance.currentUser!.uid;

  var _editedNote = Note(
      id: '',
      title: '',
      content: '',
      dateCreated: DateTime.now(),
      lastEditedDate: DateTime.now(),
      uid: '');

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      // final NoteId = ModalRoute.of(context)?.settings.arguments as String?;
      if (widget.noteId != '') {
        _editedNote = Provider.of<Storage>(context).findById(widget.noteId);
      }
      _initValues = {
        'title': _editedNote.title!,
        'content': _editedNote.content,
      };
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> saveNote() async {
    setState(() {
      _isLoading = true;
    });

    _editedNote = Note(
      id: _editedNote.id,
      title: _titleController.text,
      content: _noteController.text,
      dateCreated: _editedNote.dateCreated,
      lastEditedDate: _editedNote.lastEditedDate,
      uid: _editedNote.uid,
    );

    print('this is my ${_editedNote.id}');

    if (_editedNote.id == '') {
      try {
        // await Provider.of<Storage>(context, listen: false).addNote(_editedNote);
      } catch (e) {
        await showSnackbar(context, 'Couldn\'t add note. Error: $e');
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Note' : 'Add Note'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ThemeScreen(),
              ),
            ),
            icon: const Icon(
              Icons.color_lens,
              color: Colors.white,
            ),
          ),
          TextButton.icon(
            onPressed: saveNote,
            icon: const Icon(
              Icons.save_alt_outlined,
              color: Colors.white,
            ),
            label: const Text(
              'Save',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ],
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
                        hintText: 'Note',
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
