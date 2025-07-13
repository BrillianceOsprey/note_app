import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../domain/models/note_model.dart';

class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._init();
  static Database? _database;

  NoteDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'notes.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );

    return _database!;
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE notes(
      id TEXT PRIMARY KEY,
      title TEXT,
      content TEXT,
      timestamp TEXT
    )
    ''');
  }

  Future<List<NoteModel>> getNotes() async {
    final db = await database;
    final result = await db.query('notes');
    return result.map((json) => NoteModel.fromJson(json)).toList();
  }

  Future<void> saveNote(NoteModel note) async {
    final db = await database;
    await db.insert('notes', note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateNote(NoteModel note) async {
    final db = await database;
    await db.update(
      'notes',
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote(String id) async {
    final db = await database;
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
