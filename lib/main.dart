import 'package:flutter/material.dart';
import 'core/injection.dart';
import 'features/notes/presentation/pages/note_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const NotePage(),
    );
  }
}
