import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'note_event.dart';
import 'note_state.dart';
import '../../domain/usecases/get_all_notes.dart';
import '../../domain/usecases/add_note.dart';
import '../../domain/usecases/update_note.dart';
import '../../domain/usecases/delete_note.dart';

@injectable
class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetAllNotes getAllNotes;
  final AddNote addNote;
  final UpdateNote updateNote;
  final DeleteNote deleteNote;

  NoteBloc({
    required this.getAllNotes,
    required this.addNote,
    required this.updateNote,
    required this.deleteNote,
  }) : super(NoteInitial()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNoteEvent>(_onAddNote);
    on<UpdateNoteEvent>(_onUpdateNote);
    on<DeleteNoteEvent>(_onDeleteNote);
  }

  Future<void> _onLoadNotes(LoadNotes event, Emitter<NoteState> emit) async {
    emit(NoteLoading());
    try {
      final notes = await getAllNotes();
      emit(NoteLoaded(notes));
    } catch (_) {
      emit(const NoteError('Failed to load notes'));
    }
  }

  Future<void> _onAddNote(AddNoteEvent event, Emitter<NoteState> emit) async {
    if (state is NoteLoaded) {
      await addNote(event.note);
      add(LoadNotes());
    }
  }

  Future<void> _onUpdateNote(
      UpdateNoteEvent event, Emitter<NoteState> emit) async {
    if (state is NoteLoaded) {
      await updateNote(event.note);
      add(LoadNotes());
    }
  }

  Future<void> _onDeleteNote(
      DeleteNoteEvent event, Emitter<NoteState> emit) async {
    if (state is NoteLoaded) {
      await deleteNote(event.id);
      add(LoadNotes());
    }
  }
}
