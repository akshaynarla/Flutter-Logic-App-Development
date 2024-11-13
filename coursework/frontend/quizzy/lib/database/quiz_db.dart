import 'package:quizzy/quiz/quiz.dart';
import 'package:quizzy/quiz/quiz_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:core';

// Database creation similar to the dice exercise. from: database.dart of week9/dicey
// database architecture also inspired from:  https://github.com/zjhnb11/logic_quiz_App
// this singleton approach ensures, only one database is used throughout the app lifecycle.
class QuizDatabaseProvider {
  Database? _database;

  QuizDatabaseProvider._privateConstructor();
  static final QuizDatabaseProvider instance =
      QuizDatabaseProvider._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDb();
    return _database!;
  }

  // initialize the local quiz database with necessary tables for having the quiz
  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'quiz_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // table to store the quiz questions
        await db.execute('''
            CREATE TABLE IF NOT EXISTS quiz (
              task_id INTEGER PRIMARY KEY,
              question TEXT NOT NULL,
              choices TEXT NOT NULL,
              correctAns INTEGER
            )
          ''');
        // table to store stats
        await db.execute('''
            CREATE TABLE IF NOT EXISTS stats (
              username VARCHAR(255),
              score INTEGER,
              sessions INTEGER,
              mode VARCHAR(255) NOT NULL,
              PRIMARY KEY (username, mode)
            )
          ''');
        // table to maintain user session --> for persistence
        await db.execute('''
            CREATE TABLE IF NOT EXISTS user_session (
              username VARCHAR(255) PRIMARY KEY,
              session_token VARCHAR(255)
            )
          ''');
      },
    );
  }

  // Method to add the session's score to the total score in the sqflite database.
  // helps maintain overall stats (accuracy and number of quiz sessions attempted).
  // Update the existing entry with the new total score and session count.
  Future<void> addSessionScore(
      String? username, int newSessionScore, String mode) async {
    final db = await database;

    List<Map<String, dynamic>> existingData = await db.query(
      'stats',
      columns: ['username', 'score', 'sessions', 'mode'],
      where: 'username = ? AND mode = ?',
      whereArgs: [username, mode],
    );

    int currentSessionCount = 0;
    int currentTotalScore = 0;
    if (existingData.isNotEmpty) {
      currentTotalScore = existingData.first['score'] as int;
      currentSessionCount = existingData.first['sessions'] as int;
    }

    int newTotalScore = currentTotalScore + newSessionScore;
    int newSessionCount = currentSessionCount + 1;

    if (existingData.isNotEmpty) {
      await db.update(
        'stats',
        {'score': newTotalScore, 'sessions': newSessionCount},
        where: 'username = ? AND mode = ?',
        whereArgs: [username, mode],
      );
    }
  }

  // saveStatistics is used to save the fetched stats from the server on
  // local sqflite database
  Future<void> saveStatistics(
      String username, int score, int sessions, QuizMode mode) async {
    final db = await database;

    await db.insert(
        'stats',
        {
          'username': username,
          'score': score,
          'sessions': sessions,
          'mode': mode.toString().split('.').last,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // method for querying the local sqflite database for the statistics of a
  // specific user and mode. If stats are found, create and return a UserStatistic object
  Future<UserStatistic?> getUserStatistic(String? username, String mode) async {
    final db = await database;

    List<Map<String, dynamic>> stats = await db.query(
      'stats',
      columns: ['username', 'score', 'sessions', 'mode'],
      where: 'username = ? AND mode = ?',
      whereArgs: [username, mode],
    );

    if (stats.isNotEmpty) {
      return UserStatistic(
        username: stats.first['username'] as String,
        score: stats.first['score'] as int,
        sessionCount: stats.first['sessions'] as int,
        mode: stats.first['mode'] as String,
      );
    } else {
      return null;
    }
  }

  // loadStats from the local database to display user stats
  Future<void> sendUserStatToServer(String? username) async {
    final db = await QuizDatabaseProvider.instance.database;
    List<Map<String, dynamic>> stats = await db.query(
      'stats',
      where: 'username = ?',
      whereArgs: [username],
    );

    sendStats(stats);
  }

  // method to insert the fetched task to the local sqflite database
  // conflict algorithm helps in replacing values with same key and avoids duplicates
  Future<void> insertTasks(List<Tasks> tasks) async {
    Database db = await database;
    var batch = db.batch();
    for (var task in tasks) {
      batch.insert('quiz', task.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit();
  }

  // method to get all questions from the stored table and return a list of quiz objects.
  // the fetched json is converted to list here (similar to offlineTasks list)
  Future<List<Tasks>> getTasks() async {
    Database db = await database;
    var res = await db.query('quiz');
    List<Tasks> list =
        res.isNotEmpty ? res.map((c) => Tasks.fromJson(c)).toList() : [];

    return list;
  }

  // method deletes all data from the locally created quiz table.
  Future<void> clearQuestions() async {
    var db = await database;
    await db.delete('quiz');
  }

  // used to save the user session when logging in
  Future<void> saveUserSession(String? username, String sessionToken) async {
    final db = await database;
    await db.insert(
      'user_session',
      {
        'username': username,
        'session_token': sessionToken,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // used to get the saved username from database to persist corresponding data
  Future<Map<String, String?>> getSavedUserSession() async {
    final db = await database;
    final List<Map<String, dynamic>> sessionDb = await db.query('user_session');

    if (sessionDb.isNotEmpty) {
      return {
        'username': sessionDb.first['username'],
        'session_token': sessionDb.first['session_token'],
      };
    }
    return {'username': null, 'session_token': null};
  }

  // used to remove the user name from the sessions table
  Future<void> clearUserSession(String username) async {
    final db = await database;
    await db.delete('user_session');
  }
}
