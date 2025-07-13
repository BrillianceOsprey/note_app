import 'package:injectable/injectable.dart';

import '../models/note_model.dart';
import '../repositories/note_repository.dart';

@injectable
class GetAllNotes {
  final NoteRepository repository;

  GetAllNotes(this.repository);

  Future<List<NoteModel>> call() => repository.getAllNotes();
}
