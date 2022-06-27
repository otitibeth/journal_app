import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_journal/models/note_model.dart';
import 'package:my_journal/resources/auth_methods.dart';
import 'package:my_journal/resources/firebase_database_methods.dart';
import 'package:my_journal/screens/notelist_screen.dart';
import 'package:my_journal/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_journal/utils/colors.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Storage(),
        ),
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Journal',
        theme: ThemeData(
          primarySwatch: primaryColor,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const NoteListScreen();
                }
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Some internal error occured'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor),
                );
              }

              return const SignupScreen();
            }),
      ),
    );
  }
}
