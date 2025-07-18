import 'package:equatable/equatable.dart';
import '../../domain/models/note_model.dart';

abstract class NoteState extends Equatable {
  const NoteState();
  @override
  List<Object?> get props => [];
}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  final List<NoteModel> notes;
  const NoteLoaded(this.notes);

  @override
  List<Object?> get props => [notes];
}

class NoteError extends NoteState {
  final String message;
  const NoteError(this.message);

  @override
  List<Object?> get props => [message];
}
