import 'package:injectable/injectable.dart';

import '../models/note_model.dart';
import '../repositories/note_repository.dart';

@injectable
class UpdateNote {
  final NoteRepository repository;

  UpdateNote(this.repository);

  Future<void> call(NoteModel note) => repository.updateNote(note);
}
