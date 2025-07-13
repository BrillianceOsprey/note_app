import 'package:injectable/injectable.dart';

import '../repositories/note_repository.dart';

@injectable
class DeleteNote {
  final NoteRepository repository;

  DeleteNote(this.repository);

  Future<void> call(String id) => repository.deleteNote(id);
}
