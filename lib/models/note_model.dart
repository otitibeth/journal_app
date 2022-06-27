import 'package:flutter/cupertino.dart';

class Note with ChangeNotifier {
  final String? id;
  final String? title;
  final String content;
  final DateTime dateCreated;
  final DateTime? lastEditedDate;
  final String? uid;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.dateCreated,
    required this.lastEditedDate,
    required this.uid,
  });
}
