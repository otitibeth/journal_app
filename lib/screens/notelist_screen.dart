import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:my_journal/models/note_model.dart';
import 'package:my_journal/models/user_model.dart' as model;
import 'package:my_journal/resources/auth_methods.dart';
import 'package:my_journal/resources/firebase_database_methods.dart';
import 'package:my_journal/screens/create_note_screen.dart';
import 'package:my_journal/screens/signup_screen.dart';
import 'package:my_journal/screens/theme_screen.dart';
import 'package:my_journal/utils/utils.dart';
import 'package:my_journal/widgets/note_card.dart';
import 'package:provider/provider.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({Key? key}) : super(key: key);

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  @override
  Widget build(BuildContext context) {
    final noteData = Provider.of<Storage>(context);
    final notes = noteData.items;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Journal',
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: () async {
              // String res = await AuthMethods().signOut();

              // print(res);

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const SignupScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 15,
            ),
            label: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 9,
          ),
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: notes[index],
            child: Notecard(note: notes[index]),
          ),
          itemCount: notes.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateNoteScreen(
                noteId: '',
              ),
            ),
          );
        },
        child: const Icon(Icons.note_add_outlined),
      ),
      // drawer: Drawer(
      //   child: Column(
      //     children: [
      //       AppBar(
      //         title: Text('Hi $getUsername'),
      //       ),
      //       Text('Hi $getUsername'),
      //       ListTile(
      //         leading: Icon(
      //           Icons.color_lens,
      //           color: Theme.of(context).primaryColor,
      //         ),
      //         title: const Text(
      //           'Theme',
      //           style: TextStyle(
      //             fontSize: 16,
      //           ),
      //         ),
      //         onTap: () => Navigator.of(context).push(
      //           MaterialPageRoute(
      //             builder: (context) => const ThemeScreen(),
      //           ),
      //         ),
      //       ),
      //       const Divider(),
      //       ListTile(
      //         leading: Icon(
      //           Icons.logout,
      //           color: Theme.of(context).primaryColor,
      //         ),
      //         title: const Text(
      //           'Logout',
      //           style: TextStyle(
      //             fontSize: 16,
      //           ),
      //         ),
      //         onTap: () async {
      //           String res = await AuthMethods().signOut();

      //           print(res);

      //           Navigator.of(context).pushReplacement(
      //             MaterialPageRoute(
      //               builder: (context) => const LoginScreen(),
      //             ),
      //           );
      //         },
      //       ),
      //       const Divider(
      //         thickness: 1,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
