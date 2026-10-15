import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../db/app_database.dart';
import '../models/project_record.dart';

/// CRUD nad tabulkou `projects` (lokální historie).
class ProjectsRepository {
  ProjectsRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  static String newId() => _uuid.v4();

  Future<void> saveProject(ProjectRecord project) async {
    final db = await _db.database;
    await db.insert(
      'projects',
      project.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ProjectRecord>> loadProjects() async {
    final db = await _db.database;
    final rows = await db.query('projects', orderBy: 'created_at DESC');
    return rows.map(ProjectRecord.fromMap).toList();
  }

  Future<void> deleteProject(String id) async {
    final db = await _db.database;
    await db.delete('projects', where: 'id = ?', whereArgs: [id]);
  }
}
