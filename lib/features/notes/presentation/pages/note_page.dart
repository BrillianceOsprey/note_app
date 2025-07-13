import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/injection.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import '../bloc/note_state.dart';
import '../../domain/models/note_model.dart';
import 'package:uuid/uuid.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NoteBloc>()..add(LoadNotes()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: const Text('Notes')),
            body: BlocBuilder<NoteBloc, NoteState>(
              builder: (context, state) {
                if (state is NoteLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is NoteLoaded) {
                  return ListView.builder(
                    itemCount: state.notes.length,
                    itemBuilder: (_, i) {
                      final note = state.notes[i];
                      return ListTile(
                        title: Text(note.title),
                        subtitle: Text(note.content),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context
                                .read<NoteBloc>()
                                .add(DeleteNoteEvent(note.id));
                          },
                        ),
                      );
                    },
                  );
                }
                return const Center(child: Text('No notes'));
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                final newNote = NoteModel(
                  id: const Uuid().v4(),
                  title: 'New Note',
                  content: 'Type something...',
                  timestamp: DateTime.now(),
                );
                context.read<NoteBloc>().add(AddNoteEvent(newNote));
              },
            ),
          );
        },
      ),
    );
  }
}
