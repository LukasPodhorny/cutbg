import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

/// Lokální SQLite databáze (100 % v zařízení, viz návrh kap. 4 Data).
class AppDatabase {
  static const _fileName = 'cutbg.db';
  static const _version = 1;

  Database? _db;

  Future<Database> get database async {
    final existing = _db;
    if (existing != null) return existing;
    final dir = await getApplicationDocumentsDirectory();
    final db = await openDatabase(
      p.join(dir.path, _fileName),
      version: _version,
      onCreate: _onCreate,
    );
    _db = db;
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE projects(
        id TEXT PRIMARY KEY,
        created_at TEXT NOT NULL,
        original_image_path TEXT NOT NULL,
        mask_image_path TEXT NOT NULL,
        background_type TEXT NOT NULL,
        background_value TEXT,
        feather_value REAL NOT NULL DEFAULT 0
      )
    ''');
    await db.execute('''
      CREATE TABLE user_settings(
        id INTEGER PRIMARY KEY CHECK (id = 1),
        export_quality TEXT NOT NULL DEFAULT 'original',
        theme_mode TEXT NOT NULL DEFAULT 'system'
      )
    ''');
  }

  Future<void> close() async {
    await _db?.close();
    _db = null;
  }
}
