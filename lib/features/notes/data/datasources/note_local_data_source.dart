import 'package:injectable/injectable.dart';
import 'package:note_app/features/notes/data/datasources/note_database.dart';

import '../../domain/models/note_model.dart';

abstract class NoteLocalDataSource {
  Future<List<NoteModel>> getNotes();
  Future<void> saveNote(NoteModel note);
  Future<void> updateNote(NoteModel note);
  Future<void> deleteNote(String id);
}

@LazySingleton(as: NoteLocalDataSource)
class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final NoteDatabase db;

  NoteLocalDataSourceImpl(this.db);

  @override
  Future<List<NoteModel>> getNotes() => db.getNotes();

  @override
  Future<void> saveNote(NoteModel note) => db.saveNote(note);

  @override
  Future<void> updateNote(NoteModel note) => db.updateNote(note);

  @override
  Future<void> deleteNote(String id) => db.deleteNote(id);
}
