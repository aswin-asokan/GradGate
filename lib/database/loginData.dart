import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Logindata {
  static final Logindata _instance = Logindata._internal();
  factory Logindata() => _instance;
  Logindata._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database and create the table if not exists
  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'users.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, mail TEXT, password TEXT, user_type TEXT)",
        );
      },
      version: 1,
    );
  }

  // Function to insert user using raw SQL query
  Future<void> insertUser(
      String email, String password, String userType) async {
    final db = await database;

    // Using raw SQL insert command
    await db.rawInsert(
      "INSERT INTO users (mail, password, user_type) VALUES (?, ?, ?)",
      [email, password, userType],
    );
  }

  Future<bool> emailExists(String email) async {
    final db = await database;

    List<Map<String, dynamic>> result = await db.rawQuery(
      "SELECT * FROM users WHERE mail = ?",
      [email],
    );

    return result.isNotEmpty; // Return true if the email exists
  }

  // Function to verify user credentials
  Future<bool> verifyUser(String email, String password) async {
    final db = await database;

    // Using raw SQL select command to verify user
    final List<Map<String, dynamic>> users = await db.rawQuery(
      "SELECT * FROM users WHERE mail = ? AND password = ?",
      [email, password],
    );

    // Check if user exists
    return users.isNotEmpty;
  }

  Future<String?> getUserType(String email, String password) async {
    final db = await database;

    final List<Map<String, dynamic>> result = await db.rawQuery(
      "SELECT user_type FROM users WHERE mail = ? AND password = ?",
      [email, password],
    );

    // Check if user exists and return the user type
    if (result.isNotEmpty) {
      // Return the user type from the first result
      return result.first['user_type'] as String;
    }
    return null;
  }
}
