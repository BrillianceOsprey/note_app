import 'package:injectable/injectable.dart';

import '../models/note_model.dart';
import '../repositories/note_repository.dart';

@injectable
class AddNote {
  final NoteRepository repository;

  AddNote(this.repository);

  Future<void> call(NoteModel note) => repository.addNote(note);
}
