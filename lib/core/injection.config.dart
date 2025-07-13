// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:note_app/core/injection.dart' as _i549;
import 'package:note_app/features/notes/data/datasources/note_database.dart'
    as _i508;
import 'package:note_app/features/notes/data/datasources/note_local_data_source.dart'
    as _i53;
import 'package:note_app/features/notes/data/repositories/note_repository_impl.dart'
    as _i786;
import 'package:note_app/features/notes/domain/repositories/note_repository.dart'
    as _i776;
import 'package:note_app/features/notes/domain/usecases/add_note.dart' as _i872;
import 'package:note_app/features/notes/domain/usecases/delete_note.dart'
    as _i851;
import 'package:note_app/features/notes/domain/usecases/get_all_notes.dart'
    as _i763;
import 'package:note_app/features/notes/domain/usecases/update_note.dart'
    as _i375;
import 'package:note_app/features/notes/presentation/bloc/note_bloc.dart'
    as _i589;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final sqfliteModule = _$SqfliteModule();
    gh.lazySingleton<_i508.NoteDatabase>(() => sqfliteModule.noteDatabase);
    gh.lazySingleton<_i53.NoteLocalDataSource>(
        () => _i53.NoteLocalDataSourceImpl(gh<_i508.NoteDatabase>()));
    gh.lazySingleton<_i776.NoteRepository>(
        () => _i786.NoteRepositoryImpl(gh<_i53.NoteLocalDataSource>()));
    gh.factory<_i375.UpdateNote>(
        () => _i375.UpdateNote(gh<_i776.NoteRepository>()));
    gh.factory<_i763.GetAllNotes>(
        () => _i763.GetAllNotes(gh<_i776.NoteRepository>()));
    gh.factory<_i872.AddNote>(() => _i872.AddNote(gh<_i776.NoteRepository>()));
    gh.factory<_i851.DeleteNote>(
        () => _i851.DeleteNote(gh<_i776.NoteRepository>()));
    gh.factory<_i589.NoteBloc>(() => _i589.NoteBloc(
          getAllNotes: gh<_i763.GetAllNotes>(),
          addNote: gh<_i872.AddNote>(),
          updateNote: gh<_i375.UpdateNote>(),
          deleteNote: gh<_i851.DeleteNote>(),
        ));
    return this;
  }
}

class _$SqfliteModule extends _i549.SqfliteModule {}
