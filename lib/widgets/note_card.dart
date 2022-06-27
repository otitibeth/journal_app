import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_journal/models/note_model.dart';
import 'package:my_journal/models/user_model.dart' as model;
import 'package:my_journal/screens/create_note_screen.dart';
import 'package:my_journal/utils/colors.dart';

class Notecard extends StatefulWidget {
  const Notecard({Key? key, required this.note}) : super(key: key);
  final Note note;
  // final model.User user;

  @override
  State<Notecard> createState() => _NotecardState();
}

class _NotecardState extends State<Notecard> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  // var editedNote = Note(
  //     id: '',
  //     title: '',
  //     content: '',
  //     dateCreated: DateTime.now(),
  //     lastEditedDate: DateTime.now(),
  //     uid: );

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CreateNoteScreen(
              noteId: widget.note.id!,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: secondaryColor,
          ),
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  widget.note.title!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.note.content,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(color: Colors.grey.shade50),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                widget.note.lastEditedDate != null
                    ? 'Last editen on: ${widget.note.lastEditedDate}'
                    : 'Last editen on: ${widget.note.dateCreated}',
                style: TextStyle(
                    color: Colors.grey.shade50,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
