import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();
  static Database? _authDatabase;
  static Database? _postsDatabase;
  static const String _authDBName = "auth.db";
  static const String _postsDBName = "posts.db";

  Future<Database> get authDatabase async {
    if (_authDatabase != null) return _authDatabase!;
    _authDatabase = await _initAuthDB();
    return _authDatabase!;
  }
  Future<Database> get postsDatabase async {
    if (_postsDatabase != null) return _postsDatabase!;
    _postsDatabase = await _initPostsDB();
    return _postsDatabase!;
  }

  Future<Database> _initAuthDB() async {
    final directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _authDBName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id TEXT PRIMARY KEY,
            created_at TEXT
          )
        ''');
      },
    );
  }
  Future<Database> _initPostsDB() async {
    final directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _postsDBName);
    return await openDatabase(
      path,
      version: 3,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE posts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            option TEXT,
            content TEXT,
            posted_by TEXT,  -- Foreign key (user ID from main.db)
            created_at TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 3) {
          await db.execute('DROP TABLE IF EXISTS posts');

          await db.execute('''
          CREATE TABLE posts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            option TEXT,
            content TEXT, -- 🔄 Updated column name
            posted_by TEXT,  -- Foreign key (user ID from main.db)
            created_at TEXT
          )
          ''');

          print("✅ Posts table recreated successfully!");
        }
      },
    );
  }
  // Create a new anonymous user
  Future<String> createAnonymousUser() async {
    final db = _authDatabase;
    String userId = const Uuid().v4(); // Generate a unique user ID
    await db?.insert(
      'users',
      {'id': userId, 'created_at': DateTime.now().toIso8601String()},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    return userId;
  }
  // Check if a user exists
  Future<String?> getAnonymousUser() async {
    final db = await authDatabase;
    List<Map<String,Object?>> result = await db.query('users', limit: 1);
    if (result.isNotEmpty) {
      return result.first['id'] as String?;
    }
    return null;
  }

  Future<String> signInAnonymously() async {
    final dbHelper = DatabaseHelper();
    String? userId = await dbHelper.getAnonymousUser();
    print(userId);
    if (userId == null) {
      userId = await dbHelper.createAnonymousUser();
      print('New anonymous user created: $userId');
    } else {
      print('Existing anonymous user: $userId');
    }
    return userId;
  }

  /// 📝 Insert Post into Posts Database
  Future<void> insertPost(String option, String content) async {
    final db = await postsDatabase;
    final dbHelper = DatabaseHelper();
    String? userId = await dbHelper.getAnonymousUser();
    await db.insert(
      'posts',
      {
        'option': option,
        'content': content,
        'posted_by': userId, // ✅ Link post to a user
        'created_at': DateTime.now().toIso8601String(),
      },
    );
  }

  /// 📜 Get All Posts with User ID
  Future<List<Map<String, dynamic>>> getPosts() async {
    final db = await postsDatabase;
    return await db.query('posts');
  }
  Future<List<Map<String, dynamic>>> getAllPostsOfUser() async {
    final db = await postsDatabase;
    final dbHelper = DatabaseHelper();
    String? userId = await dbHelper.getAnonymousUser();
    return await db.query(
      'posts',
      where: "posted_by = ?",
      whereArgs: [userId],
    );
  }
  Future<List<Map<String, dynamic>>> getPostsByUserToday() async {
    final db = await postsDatabase;
    final dbHelper = DatabaseHelper();
    String? userId = await dbHelper.getAnonymousUser();
    String today = DateTime.now().toIso8601String().split('T')[0]; // Get only the date part

    return await db.query(
      'posts',
      where: "posted_by = ? AND created_at LIKE ?",
      whereArgs: [userId, '$today%'], // Matches date format 'YYYY-MM-DD%'
    );
  }

  /// Close Databases When Not Needed
  Future<void> closeDatabases() async {
    if (_authDatabase != null) {
      await _authDatabase!.close();
      _authDatabase = null;
    }
    if (_postsDatabase != null) {
      await _postsDatabase!.close();
      _postsDatabase = null;
    }
  }
}
