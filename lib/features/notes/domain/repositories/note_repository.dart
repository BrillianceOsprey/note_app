import '../models/note_model.dart';

abstract class NoteRepository {
  Future<List<NoteModel>> getAllNotes();
  Future<void> addNote(NoteModel note);
  Future<void> updateNote(NoteModel note);
  Future<void> deleteNote(String id);
}
