import 'package:injectable/injectable.dart';

import '../../domain/models/note_model.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/note_local_data_source.dart';

@LazySingleton(as: NoteRepository)
class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource localDataSource;

  NoteRepositoryImpl(this.localDataSource);

  @override
  Future<List<NoteModel>> getAllNotes() => localDataSource.getNotes();

  @override
  Future<void> addNote(NoteModel note) => localDataSource.saveNote(note);

  @override
  Future<void> updateNote(NoteModel note) => localDataSource.updateNote(note);

  @override
  Future<void> deleteNote(String id) => localDataSource.deleteNote(id);
}
