import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Employer {
  static final Employer _instance = Employer._internal();
  factory Employer() => _instance;
  Employer._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database and create the table if not exists
  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'employer.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS employer (id INTEGER PRIMARY KEY AUTOINCREMENT, mail TEXT, company_name TEXT, industry_type TEXT, location TEXT, about TEXT, phone TEXT, image TEXT,FOREIGN KEY (mail) REFERENCES users(mail) ON DELETE CASCADE)",
        );
      },
      version: 1,
    );
  }

  // Function to insert user using raw SQL query
  Future<void> insertEmployer(
      String email,
      String companyName,
      String industryType,
      String location,
      String about,
      String phone,
      String image) async {
    final db = await database;

    // Using raw SQL insert command
    await db.rawInsert(
      "INSERT INTO employer (mail, company_name, industry_type, location, about, phone, image) VALUES (?, ?, ?, ?, ?, ?, ?)",
      [email, companyName, industryType, location, about, phone, image],
    );
  }

  Future<String?> getUserType(String email, String password) async {
    final db = await database;

    final List<Map<String, dynamic>> result = await db.rawQuery(
      "SELECT user_type FROM employer WHERE mail = ? AND password = ?",
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
