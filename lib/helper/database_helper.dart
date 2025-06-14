import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app.db');
    return await openDatabase(
      path,
      version: 2, // Incremented version
      onCreate: _createTables,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE,
        password TEXT,
        usertype TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE,
        name TEXT,
        college TEXT,
        department TEXT,
        phone TEXT,
        about TEXT,
        link TEXT
      )
    ''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS colleges (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      email TEXT UNIQUE,
      name TEXT,
      location TEXT,
      phone TEXT
    )
  ''');
    await db.execute('''
  CREATE TABLE IF NOT EXISTS employers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT UNIQUE,
    name TEXT,
    location TEXT,
    type TEXT,
    phone TEXT,
    about TEXT,
    link TEXT
  )
''');
    await db.execute('''
  CREATE TABLE IF NOT EXISTS jobs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    employer_id INTEGER,
    title TEXT,
    status TEXT,
    description TEXT,
    branches TEXT,
    salary TEXT,
    date TEXT,
    type TEXT,
    FOREIGN KEY (employer_id) REFERENCES employers(id)
  )
''');
    await db.execute('''
  CREATE TABLE IF NOT EXISTS applied (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    job_id INTEGER NOT NULL,
    student_id INTEGER NOT NULL,
    reply TEXT DEFAULT 'waiting',
    status TEXT DEFAULT 'pending',
    FOREIGN KEY (job_id) REFERENCES jobs(id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    UNIQUE(job_id, student_id)
  )
''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS students (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          email TEXT UNIQUE,
          name TEXT,
          college TEXT,
          department TEXT,
          phone TEXT,
          about TEXT,
          link TEXT
        )
      ''');
      await db.execute('''
      CREATE TABLE IF NOT EXISTS colleges (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE,
        name TEXT,
        location TEXT,
        phone TEXT
      )
    ''');
      await db.execute('''
    CREATE TABLE IF NOT EXISTS employers (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      email TEXT UNIQUE,
      name TEXT,
      location TEXT,
      type TEXT,
      phone TEXT,
      about TEXT,
      link TEXT
    )
  ''');
      await db.execute('''
  CREATE TABLE IF NOT EXISTS jobs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    employer_id INTEGER,
    title TEXT,
    status TEXT,
    description TEXT,
    branches TEXT,
    salary TEXT,
    date TEXT,
    type TEXT,
    FOREIGN KEY (employer_id) REFERENCES employers(id)
  )
''');
      await db.execute('''
  CREATE TABLE IF NOT EXISTS applied (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    job_id INTEGER NOT NULL,
    student_id INTEGER NOT NULL,
    status TEXT DEFAULT 'pending',
    reply TEXT DEFAULT 'waiting',
    FOREIGN KEY (job_id) REFERENCES jobs(id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    UNIQUE(job_id, student_id)
  )
''');
    }
  }

  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert(
      'users',
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertStudent(Map<String, dynamic> student) async {
    final db = await database;
    await db.insert(
      'students',
      student,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertCollege(Map<String, dynamic> college) async {
    final db = await database;
    await db.insert(
      'colleges',
      college,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertEmployer(Map<String, dynamic> employer) async {
    final db = await database;
    await db.insert(
      'employers',
      employer,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> verifyOldPassword(String email, String oldPassword) async {
    final db = await database;

    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, oldPassword],
    );

    return result.isNotEmpty;
  }

  Future<bool> updatePassword(String email, String newPassword) async {
    final db = await database;

    final count = await db.update(
      'users',
      {'password': newPassword},
      where: 'email = ?',
      whereArgs: [email],
    );

    return count > 0; // returns true if update was successful
  }

  Future<bool> updateUserDetails({
    required String mail,
    required Map<String, dynamic> updatedFields,
    required String type, // 👈 pass this instead of relying on userType
  }) async {
    final db = await database;

    final userFields = <String, dynamic>{};
    for (final key in ['password', 'usertype']) {
      if (updatedFields.containsKey(key)) {
        userFields[key] = updatedFields[key];
      }
    }

    int userUpdateCount = 0;
    if (userFields.isNotEmpty) {
      userUpdateCount = await db.update(
        'users',
        userFields,
        where: 'email = ?',
        whereArgs: [mail],
      );
    }

    String? detailTable;
    switch (type.toLowerCase()) {
      case 'student':
        detailTable = 'students';
        break;
      case 'employer':
        detailTable = 'employers';
        break;
      case 'college':
        detailTable = 'colleges';
        break;
      default:
        return false;
    }

    final detailUpdateCount = await db.update(
      detailTable,
      updatedFields,
      where: 'email = ?',
      whereArgs: [mail],
    );

    return userUpdateCount > 0 || detailUpdateCount > 0;
  }

  Future<void> insertJob(Map<String, dynamic> job) async {
    final db = await database;
    await db.insert(
      'jobs',
      job,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getJobsForEmployer(String email) async {
    final db = await database;

    final result = await db.rawQuery('''
    SELECT jobs.*, 
           employers.name AS employer_name,
           employers.location AS employer_location,
           employers.link AS employer_pic
    FROM jobs
    JOIN employers ON jobs.employer_id = employers.id
    WHERE employers.email = ?
    ORDER BY jobs.date DESC
  ''', [email]);

    return result;
  }

  Future<int?> getEmployerIdByEmail(String email) async {
    final db = await database;
    final result = await db.query(
      'employers',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first['id'] as int;
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> getAllJobsForStudents(
      String department) async {
    final db = await database;
    final result = await db.rawQuery('''
    SELECT jobs.*, 
           employers.name AS employer_name, 
           employers.location AS employer_location, 
           employers.link AS employer_pic
    FROM jobs
    INNER JOIN employers ON jobs.employer_id = employers.id
    WHERE jobs.status = 'active'
      AND (',' || jobs.branches || ',') LIKE ?
  ''', ['%,$department,%']);

    return result;
  }

  Future<void> applyToJob(int jobId, int studentId, String status) async {
    final db = await database;
    await db.insert(
      'applied',
      {
        'job_id': jobId,
        'student_id': studentId,
        'reply': "waiting",
        'status': status,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore, // ignore duplicate
    );
  }

  Future<bool> hasAlreadyApplied(int jobId, int studentId) async {
    final db = await DBHelper().database;
    final result = await db.query(
      'applied',
      where: 'job_id = ? AND student_id = ?',
      whereArgs: [jobId, studentId],
    );
    return result.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> getJobsAppliedByCurrentStudent(
      int id) async {
    final db = await database;
    final studentId = id;

    final result = await db.rawQuery('''
    SELECT jobs.id AS job_id, jobs.*, applied.status AS application_status, applied.reply 
FROM applied 
JOIN jobs ON applied.job_id = jobs.id
WHERE applied.student_id = ?
  ''', [studentId]);

    return result;
  }

  Future<void> updateStudentReply(int jobId, String reply, int id) async {
    final db = await database;
    final studentId = id;

    await db.update(
      'applied',
      {'reply': reply},
      where: 'job_id = ? AND student_id = ?',
      whereArgs: [jobId, studentId],
    );
  }

  Future<Map<String, int>> getJobStatsForStudent(int studentId) async {
    final db = await database;

    // Count for each application status
    final appliedCount = Sqflite.firstIntValue(await db.rawQuery('''
    SELECT COUNT(*) FROM applied
    WHERE student_id = ? AND status = 'applied'
  ''', [studentId])) ?? 0;

    final selectedCount = Sqflite.firstIntValue(await db.rawQuery('''
    SELECT COUNT(*) FROM applied
    WHERE student_id = ? AND status = 'selected'
  ''', [studentId])) ?? 0;

    final rejectedCount = Sqflite.firstIntValue(await db.rawQuery('''
    SELECT COUNT(*) FROM applied
    WHERE student_id = ? AND status = 'rejected'
  ''', [studentId])) ?? 0;

    // Count of selected jobs where student has not replied yet
    final waitingReplyCount = Sqflite.firstIntValue(await db.rawQuery('''
    SELECT COUNT(*) FROM applied
    WHERE student_id = ? AND status = 'waiting'
  ''', [studentId])) ?? 0;

    return {
      'applied': appliedCount,
      'selected': selectedCount,
      'rejected': rejectedCount,
      'waiting_reply': waitingReplyCount,
    };
  }

  Future<List<Map<String, dynamic>>> getStudentsForJob(int jobId) async {
    final db = await database;

    final result = await db.rawQuery('''
    SELECT students.id AS students_id,students.*, applied.status AS application_status, applied.reply
    FROM applied
    JOIN students ON applied.student_id = students.id
    WHERE applied.job_id = ?
  ''', [jobId]);

    return result;
  }

  Future<void> updateStudentApplicationStatus({
    required int jobId,
    required int studentId,
    required String newStatus,
  }) async {
    final db = await database;
    await db.update(
      'applied',
      {'status': newStatus},
      where: 'job_id = ? AND student_id = ?',
      whereArgs: [jobId, studentId],
    );
  }

  Future<bool> hasAcceptedOtherOffer(
      {required int studentId, required int currentJobId}) async {
    final db = await DBHelper().database;

    final result = await db.rawQuery('''
    SELECT 1 FROM applied
    WHERE student_id = ? AND job_id != ? AND status = 'selected' AND reply = 'accepted'
    LIMIT 1
  ''', [studentId, currentJobId]);

    return result.isNotEmpty;
  }

  Future<void> updateJobStatusToClosed(int jobId) async {
    final db = await database;
    await db.update(
      'jobs',
      {'status': 'closed'},
      where: 'id = ?',
      whereArgs: [jobId],
    );
  }

  Future<void> updateJobStatus(int jobId, String newStatus) async {
    final db = await database;
    await db.update(
      'jobs',
      {'status': newStatus},
      where: 'id = ?',
      whereArgs: [jobId],
    );
  }

  Future<bool> hasAcceptedOffer(int studentId) async {
    final db = await DBHelper().database;

    final result = await db.rawQuery('''
    SELECT * FROM applied
    WHERE student_id = ? AND reply = 'accepted'
  ''', [studentId]);

    return result.isNotEmpty;
  }

  Future<Map<String, dynamic>> getCompanyStats(int companyId) async {
    final db = await DBHelper().database;

    // Total number of applications for jobs posted by this company
    final totalApplications = Sqflite.firstIntValue(await db.rawQuery('''
    SELECT COUNT(*) FROM applied
  JOIN jobs ON jobs.id = applied.job_id
  WHERE jobs.employer_id = ? AND (applied.reply IS NULL OR applied.reply != 'accepted')
  ''', [companyId])) ?? 0;

    // Total number of students hired (reply = accepted)
    final totalHired = Sqflite.firstIntValue(await db.rawQuery('''
    SELECT COUNT(*) FROM applied
    JOIN jobs ON jobs.id = applied.job_id
    WHERE jobs.employer_id = ? AND applied.reply = 'accepted'
  ''', [companyId])) ?? 0;

    // Total number of active jobs (open or in progress)
    final activeJobs = Sqflite.firstIntValue(await db.rawQuery('''
    SELECT COUNT(*) FROM jobs
    WHERE employer_id = ? AND (status = 'active' OR status = 'in progress')
  ''', [companyId])) ?? 0;

    // Average salary offered by company (assumes 'salary' column in jobs table)
    final avgSalary = Sqflite.firstIntValue(await db.rawQuery('''
    SELECT CAST(AVG(CAST(salary AS REAL)) AS INTEGER) FROM jobs
    WHERE employer_id = ?
  ''', [companyId])) ?? 0;

    return {
      'applications': totalApplications,
      'hired': totalHired,
      'activeJobs': activeJobs,
      'averageSalary': avgSalary,
    };
  }

  Future<Map<String, dynamic>> fetchSelectedStudentsWithCompany(
      String collName) async {
    final db = await database;

    final result = await db.rawQuery('''
    SELECT 
      students.*,
      employers.name AS company
    FROM students
    JOIN applied ON students.id = applied.student_id
    JOIN jobs ON applied.job_id = jobs.id
    JOIN employers ON jobs.employer_id = employers.id
    WHERE students.college = ? AND applied.status = 'selected'
  ''', [collName]);

    return {'stdData': result};
  }

  Future<Map<String, dynamic>> getCollegeDashboardData(
      String collegeName) async {
    final db = await database;
    final appliedCountResult = Sqflite.firstIntValue(await db.rawQuery('''
    SELECT COUNT(DISTINCT applied.student_id) AS applied_count
    FROM applied
    JOIN students ON students.id = applied.student_id
    WHERE students.college = ?
  ''', [collegeName])) ?? 0;

    final hiredCountResult = Sqflite.firstIntValue(await db.rawQuery('''
     SELECT COUNT(DISTINCT applied.student_id) AS hired_count
    FROM applied
    JOIN students ON students.id = applied.student_id
    WHERE students.college = ? AND applied.reply = 'accepted'
  ''', [collegeName])) ?? 0;

    final activeJobsResult = Sqflite.firstIntValue(await db.rawQuery('''
    SELECT COUNT(*) AS active_jobs
  FROM jobs
  WHERE status = 'active'
  ''')) ?? 0;

    final avgSalaryResult = Sqflite.firstIntValue(await db.rawQuery('''
    SELECT CAST(AVG(CAST(salary AS REAL)) AS INTEGER) AS avg_salary
    FROM applied
    JOIN jobs ON applied.job_id = jobs.id
    JOIN students ON students.id = applied.student_id
    WHERE applied.status = 'selected' AND students.college = ?
  ''', [collegeName])) ?? 0;

    return {
      'applied': appliedCountResult,
      'hired': hiredCountResult,
      'active_jobs': activeJobsResult,
      'avg_salary': avgSalaryResult
    };
  }

  Future<List<String>> fetchCollegeNames() async {
    final db = await database;
    final result = await db.query('colleges', columns: ['name']);
    return result.map((row) => row['name'] as String).toList();
  }

  Future<void> deleteUserByEmail(String varMail, String userType) async {
    final db = await database;

    // Delete from users table
    await db.delete(
      'users',
      where: 'email = ?',
      whereArgs: [varMail],
    );

    if (userType == 'Student') {
      // Get student ID
      final student = await db.query(
        'students',
        where: 'email = ?',
        whereArgs: [varMail],
      );

      if (student.isNotEmpty) {
        int studentId = student.first['id'] as int;

        // Delete from applied
        await db.delete(
          'applied',
          where: 'student_id = ?',
          whereArgs: [studentId],
        );

        // Delete student
        await db.delete(
          'students',
          where: 'email = ?',
          whereArgs: [varMail],
        );
      }
    } else if (userType == 'College') {
      // Get college name
      final college = await db.query(
        'colleges',
        where: 'email = ?',
        whereArgs: [varMail],
      );

      if (college.isNotEmpty) {
        String collegeName = college.first['name'] as String;

        // Delete all students from that college
        await db.delete(
          'students',
          where: 'college = ?',
          whereArgs: [collegeName],
        );

        // Delete college
        await db.delete(
          'colleges',
          where: 'email = ?',
          whereArgs: [varMail],
        );
      }
    } else if (userType == 'Employer') {
      // Get employer ID
      final employer = await db.query(
        'employers',
        where: 'email = ?',
        whereArgs: [varMail],
      );

      if (employer.isNotEmpty) {
        int employerId = employer.first['id'] as int;

        // Get all job IDs posted by the employer
        final jobs = await db.query(
          'jobs',
          where: 'employer_id = ?',
          whereArgs: [employerId],
        );

        for (var job in jobs) {
          int jobId = job['id'] as int;

          // Delete all applications for each job
          await db.delete(
            'applied',
            where: 'job_id = ?',
            whereArgs: [jobId],
          );
        }

        // Delete all jobs
        await db.delete(
          'jobs',
          where: 'employer_id = ?',
          whereArgs: [employerId],
        );

        // Delete employer
        await db.delete(
          'employers',
          where: 'email = ?',
          whereArgs: [varMail],
        );
      }
    }
  }
}
