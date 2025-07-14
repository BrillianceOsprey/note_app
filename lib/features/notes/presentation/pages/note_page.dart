import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
                  if (state.notes.isEmpty) {
                    return const Center(child: Text('No notes yet.'));
                  }
                  return ListView.builder(
                    itemCount: state.notes.length,
                    itemBuilder: (_, i) {
                      final note = state.notes[i];
                      return ListTile(
                        title: Text(note.title),
                        subtitle: Text(
                          '${note.content}\n${DateFormat.yMMMd().add_jm().format(note.timestamp)}',
                        ),
                        isThreeLine: true,
                        onTap: () =>
                            _showNoteDialog(context, existingNote: note),
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
                return const Center(child: Text('Failed to load notes'));
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => _showNoteDialog(context),
            ),
          );
        },
      ),
    );
  }

  void _showNoteDialog(BuildContext context, {NoteModel? existingNote}) {
    final titleController = TextEditingController(text: existingNote?.title);
    final contentController =
        TextEditingController(text: existingNote?.content);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(existingNote == null ? 'New Note' : 'Edit Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final title = titleController.text.trim();
              final content = contentController.text.trim();

              if (title.isNotEmpty && content.isNotEmpty) {
                final note = NoteModel(
                  id: existingNote?.id ?? const Uuid().v4(),
                  title: title,
                  content: content,
                  timestamp: DateTime.now(),
                );

                if (existingNote == null) {
                  context.read<NoteBloc>().add(AddNoteEvent(note));
                } else {
                  context.read<NoteBloc>().add(UpdateNoteEvent(note));
                }

                Navigator.pop(ctx);
              }
            },
            child: Text(existingNote == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }
}
