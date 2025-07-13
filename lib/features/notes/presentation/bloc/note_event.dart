import 'package:equatable/equatable.dart';
import '../../domain/models/note_model.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();
  @override
  List<Object?> get props => [];
}

class LoadNotes extends NoteEvent {}

class AddNoteEvent extends NoteEvent {
  final NoteModel note;
  const AddNoteEvent(this.note);

  @override
  List<Object?> get props => [note];
}

class UpdateNoteEvent extends NoteEvent {
  final NoteModel note;
  const UpdateNoteEvent(this.note);

  @override
  List<Object?> get props => [note];
}

class DeleteNoteEvent extends NoteEvent {
  final String id;
  const DeleteNoteEvent(this.id);

  @override
  List<Object?> get props => [id];
}
