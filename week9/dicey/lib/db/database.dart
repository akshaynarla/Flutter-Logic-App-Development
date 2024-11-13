import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    // Get location using getDatabasesPath
    String path = join(await getDatabasesPath(), 'dice_database.db');

    // Open/create the database at given path
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // table to store the sum statistics
        await db.execute('''
          CREATE TABLE sum_stats(
            id INTEGER PRIMARY KEY,
            sumIndex INTEGER,
            count INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE throw_stats(
            id INTEGER PRIMARY KEY,
            numOfThrows INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE matrix_stats(
            id INTEGER PRIMARY KEY,
            row INTEGER,
            col INTEGER,
            value INTEGER
          )
        ''');
      },
    );
  }
}
