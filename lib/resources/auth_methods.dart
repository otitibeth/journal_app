import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_journal/models/http_exception.dart';
import 'package:my_journal/models/note_model.dart';
import 'package:my_journal/resources/firebase_database_methods.dart';
import 'package:my_journal/utils/utils.dart';
import '../models/user_model.dart' as model;
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? expiryDate;
  String? _userId;

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDTbQio0efQeHUnhIpadFvXuXpzNyQA0l8';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {'email': email, 'password': password, 'returnSecureToken': true},
        ),
      );
      print(json.decode(response.body));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> signin(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}

// class AuthMethods {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<String> signupUser({
//     required String email,
//     required String password,
//     required String name,
//   }) async {
//     String res = 'some error occured';
//     try {
//       if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
//         // register user
//         final User cred = (await _auth.createUserWithEmailAndPassword(
//                 email: email, password: password))
//             .user!;

//         print(cred.uid);

//         // add user to database
//         Map user = {
//           "name": name,
//           "email": email,
//           "uid": cred.uid,
//         };

//         await noteAppRef.child('users').child(cred.uid).set(user);

//         res = 'success';
//       }
//     } catch (e) {
//       print(e);
//       res = e.toString();
//     }
//     return res;
//   }

//   // login user
//   Future<String> loginUser({
//     required String email,
//     required String password,
//   }) async {
//     String res = 'some error ocurred';

//     try {
//       if (email.isNotEmpty || password.isNotEmpty) {
//         await _auth.signInWithEmailAndPassword(
//             email: email, password: password);

//         res = 'success';
//       } else {
//         res = 'please enter all fields correctly';
//       }
//     } catch (err) {
//       res = err.toString();
//     }
//     return res;
//   }

//   // signout user
//   Future<String> signOut() async {
//     String res = 'couldn\'t signout';
//     await _auth.signOut();

//     res = 'signedOut';
//     return res;
//   }
// }
