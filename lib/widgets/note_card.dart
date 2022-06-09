import 'package:flutter/material.dart';
import 'package:my_journal/screens/create_note_screen.dart';

class Notecard extends StatelessWidget {
  const Notecard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const CreateNoteScreen(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.pink,
          ),
          child: Column(children: [
            Text(
              'Title',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              'This is my note',
              overflow: TextOverflow.ellipsis,
              maxLines: 12,
              style: TextStyle(color: Colors.grey.shade50),
            ),
            Text(
              '06/08/2022',
              style: TextStyle(color: Colors.grey.shade50, fontSize: 10),
            ),
          ]),
        ),
      ),
    );
  }
}
