import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE user(id INTEGER PRIMARY KEY, email TEXT, senha TEXT)',
        );
      },
    );
  }

  // Salva o usuário no banco de dados
  Future<void> saveUser(String email, String senha) async {
    final db = await database;
    await db.insert(
      'user',
      {'email': email, 'senha': senha},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Recupera o usuário do banco de dados
  Future<Map<String, dynamic>?> getUser() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('user');

    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  // Remove o usuário do banco de dados (logout)
  Future<void> deleteUser() async {
    final db = await database;
    await db.delete('user');
  }
}
