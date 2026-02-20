import 'package:login_app/json/users.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const databaseName = "auth.db";
  static const tableName = "users";

  static Database? _database;

  // Singleton pattern (Prevents multiple DB instances)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            usrId INTEGER PRIMARY KEY AUTOINCREMENT,
            fullName TEXT,
            email TEXT,
            usrName TEXT UNIQUE,
            usrPassword TEXT
          )
        ''');
      },
    );
  }

  // ✅ Create User
  Future<int> createUser(User user) async {
    final db = await database;
    return await db.insert(
      tableName,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  // ✅ Secure Authentication (No SQL Injection)
  Future<User?> authenticate(String username, String password) async {
    final db = await database;

    final result = await db.query(
      tableName,
      where: "usrName = ? AND usrPassword = ?",
      whereArgs: [username, password],
    );

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

  // ✅ Get User
  Future<User?> getUser(String username) async {
    final db = await database;

    final result = await db.query(
      tableName,
      where: "usrName = ?",
      whereArgs: [username],
    );

    return result.isNotEmpty ? User.fromMap(result.first) : null;
  }
}
