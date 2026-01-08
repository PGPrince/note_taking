import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:note_taking/notes_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://zqkxlaesgpmonwsrjbbb.supabase.co',
    anonKey: 'sb_publishable_8ZH9-GLhTphNJlNiAl6J0A_GrJppoLm',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NotesScreen());
  }
}
