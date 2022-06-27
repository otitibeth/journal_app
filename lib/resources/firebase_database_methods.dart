import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_journal/models/note_model.dart';

DatabaseReference noteAppRef = FirebaseDatabase.instance.ref().child("NoteApp");

class Storage with ChangeNotifier {
  List<Note> _items = [
    Note(
      id: 'n1',
      title: 'Note 1',
      content:
          'This is my first note, and i want to make sure that it is very very very extremely incredibly importantly, and most exceeeedingly long as f***. Although, i\'m not so sure that i have actually succeeded in that yet. which means that i am going to have to continue typing until i actually achieve it',
      dateCreated: DateTime.now(),
      lastEditedDate: DateTime.now(),
      uid: '',
    ),
    Note(
      id: 'n2',
      title: 'Note 2',
      content:
          'This is my second note, and i want to make sure that it is very very very extremely incredibly importantly, and most exceeeedingly long as f***. Although, i\'m not so sure that i have actually succeeded in that yet. which means that i am going to have to continue typing until i actually achieve it',
      dateCreated: DateTime.now(),
      lastEditedDate: DateTime.now(),
      uid: '',
    ),
    Note(
      id: 'n3',
      title: 'Note 3',
      content:
          'This is my third note, and i want to make sure that it is very very very extremely incredibly importantly, and most exceeeedingly long as f***. Although, i\'m not so sure that i have actually succeeded in that yet. which means that i am going to have to continue typing until i actually achieve it',
      dateCreated: DateTime.now(),
      lastEditedDate: DateTime.now(),
      uid: '',
    ),
    Note(
      id: 'n4',
      title: 'Note 4',
      content:
          'This is my fourth note, and i want to make sure that it is very very very extremely incredibly importantly, and most exceeeedingly long as f***. Although, i\'m not so sure that i have actually succeeded in that yet. which means that i am going to have to continue typing until i actually achieve it',
      dateCreated: DateTime.now(),
      lastEditedDate: DateTime.now(),
      uid: '',
    ),
  ];

  // List<Note> items =;

  List<Note> get items {
    // notifyListeners();
    return [..._items];
  }

  Note findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  // var userId = FirebaseAuth.instance.currentUser!.uid;

  // Future<String> addNote(
  //   Note note,
  // ) async {
  //   String res = 'some error occurred';
  //   const url =
  //       'https://my-journal-b788d-default-rtdb.firebaseio.com/NoteApp/notes.json';
  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       body: json.encode({
  //         'title': note.title,
  //         'content': note.content,
  //         'uid': userId,
  //         'dateCreated': note.dateCreated,
  //         'lastEditedDate': note.lastEditedDate,
  //       }),
  //     );
  //     print(json.decode(response.body));

  //     final newNote = Note(
  //         id: json.decode(response.body)['name'],
  //         title: note.title,
  //         content: note.content,
  //         dateCreated: note.dateCreated,
  //         lastEditedDate: note.lastEditedDate,
  //         uid: userId);
  //     _items.insert(0, newNote);
  //     notifyListeners();
  //     res = 'success';
  //   } catch (e) {
  //     res = e.toString();
  //   }
  //   return res;
  // }

  // Future<String> getNotes(String uid) async {
  //   final noteUid = _items.indexWhere((note) => note.uid == uid);
  //   String res = 'some error occurred';
  //   final url =
  //       'https://my-journal-b788d-default-rtdb.firebaseio.com/NoteApp/notes.json?orderBy="$uid"&equalto=$userId';
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //     final List<Note> loadedNote = [];
  //     extractedData.forEach((noteId, noteData) {
  //       loadedNote.add(Note(
  //         id: noteId,
  //         title: noteData['title'],
  //         content: noteData['content'],
  //         dateCreated: noteData['dateCreated'],
  //         lastEditedDate: noteData['lastEditedDate'],
  //         uid: noteData['uid'],
  //       ));
  //       _items = loadedNote;
  //       res = 'success';
  //       notifyListeners();
  //       print(response.body);
  //       print(res);
  //     });
  //   } catch (e) {
  //     res = e.toString();
  //   }
  //   return res;
  // }

  // Future<String> addUser() async {
  //  final url = 'https://my-journal-b788d-default-rtdb.firebaseio.com/noteApp/users';
  // }
}
