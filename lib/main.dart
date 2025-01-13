import 'package:flutter/material.dart';
import 'package:app_uas1/pages/login_page.dart';
import 'package:app_uas1/pages/notes_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MemoSafe',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/notes': (context) => const NotesPage(),
      },
    );
  }
}
