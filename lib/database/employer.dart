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
          "CREATE TABLE IF NOT EXISTS employer (id INTEGER PRIMARY KEY AUTOINCREMENT, mail TEXT, company_name TEXT, industry_type TEXT, location TEXT, about TEXT, phone TEXT, image TEXT, FOREIGN KEY (mail) REFERENCES users(mail) ON DELETE CASCADE)",
        );
      },
      version: 1,
    );
  }

  // Function to insert employer using raw SQL query
  Future<void> insertEmployer(
      String email,
      String companyName,
      String industryType,
      String location,
      String aboutJson,
      String phone,
      String image) async {
    final db = await database;

    // Using raw SQL insert command
    await db.rawInsert(
      "INSERT INTO employer (mail, company_name, industry_type, location, about, phone, image) VALUES (?, ?, ?, ?, ?, ?, ?)",
      [email, companyName, industryType, location, aboutJson, phone, image],
    );
  }

  Future<void> updateEmployer(
      String email,
      String companyName,
      String industryType,
      String location,
      String aboutJson,
      String phone,
      String image) async {
    final db = await database;

    // Using raw SQL insert command
    await db.rawInsert(
      "update employer set mail=?, company_name=?, industry_type=?, location=?, about=?, phone=?, image=? WHERE mail = ?",
      [
        email,
        companyName,
        industryType,
        location,
        aboutJson,
        phone,
        image,
        email
      ],
    );
  }

// Function to retrieve all employers from the database
  Future<List<Map<String, dynamic>>> getEmployers(String email) async {
    final db = await database;

    // Using raw SQL query to retrieve all rows from the employer table
    final List<Map<String, dynamic>> employers =
        await db.rawQuery("SELECT * FROM employer where mail = ?", [email]);

    return employers;
  }
}
