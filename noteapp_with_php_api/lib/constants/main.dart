import 'package:flutter/material.dart';
import 'package:noteapp_with_php_api/app/notes/addnotes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app/auth/login.dart';
import '../app/auth/signup.dart';
import '../app/home.dart';

late SharedPreferences sharepref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharepref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      home: const Home(),
      initialRoute: sharepref.getString("user_id") == null ? "login" : "home",
      routes: {
        "home": (context) => Home(),
        "login": (context) => Login(),
        "signup": (context) => Signup(),
        "addnote": (context) => AddNote(),
        // "editnote": (context) => Editnote()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
