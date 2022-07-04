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
  final _titleFocusNode = FocusNode();
  final _noteFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  bool get _isEditing => widget.noteId != '';
  var _isLoading = false;
  var _isInit = false;

  var _initValues = {
    'title': '',
    'content': '',
  };

  var _editedNote = Note(
    id: '',
    title: '',
    content: '',
    dateCreated: DateTime.now().toString(),
    lastEditedDate: '',
    // uid: '',
  );

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _noteFocusNode.dispose();
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
      final noteId = ModalRoute.of(context)?.settings.arguments as String?;
      if (noteId != '') {
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

  void saveNote() {
    // setState(() {
    //   _isLoading = true;
    // });

    // _editedNote = Note(
    //   id: _editedNote.id,
    //   title: _titleController.text,
    //   content: _noteController.text,
    //   dateCreated: _editedNote.dateCreated,
    //   lastEditedDate: _editedNote.lastEditedDate,
    //   // uid: _editedNote.uid,
    // );

    print('this is my ${_editedNote.id}');

    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    if (_editedNote.id == '') {
      // try {
      Provider.of<Storage>(context, listen: false).addNote(_editedNote);
      // } catch (e) {
      //   await showSnackbar(context, 'Couldn\'t add note. Error: $e');
      // }
    } else {
      Provider.of<Storage>(context, listen: false)
          .updateNote(_editedNote.id, _editedNote);
    }
    // setState(() {
    //   _isLoading = false;
    // });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      TextFormField(
                        initialValue: _initValues['title'],
                        decoration: const InputDecoration(
                          hintText: 'Title',
                          hintStyle: TextStyle(
                            fontSize: 25,
                          ),
                          border: InputBorder.none,
                        ),
                        focusNode: _titleFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_titleFocusNode);
                        },
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Title.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedNote = Note(
                            title: value,
                            content: _editedNote.content,
                            id: _editedNote.id,
                            dateCreated: _editedNote.dateCreated,
                            lastEditedDate: _editedNote.lastEditedDate,
                          );
                        },
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        initialValue: _initValues['content'],
                        decoration: const InputDecoration(
                          hintText: 'Note',
                          border: InputBorder.none,
                        ),
                        focusNode: _noteFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_noteFocusNode);
                        },
                        minLines: 1,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Note.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedNote = Note(
                            title: _editedNote.title,
                            content: value ?? '',
                            id: _editedNote.id,
                            dateCreated: _editedNote.dateCreated,
                            lastEditedDate: _editedNote.lastEditedDate,
                          );
                        },
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
