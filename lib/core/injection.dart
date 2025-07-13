import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';
import '../features/notes/data/datasources/note_database.dart';

final GetIt sl = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => sl.init();

@module
abstract class SqfliteModule {
  @lazySingleton
  NoteDatabase get noteDatabase => NoteDatabase.instance;
}
