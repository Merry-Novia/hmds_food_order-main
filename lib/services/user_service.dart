import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_model.dart';

class UserService {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), "users.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          telepon TEXT,
          deskripsi TEXT
        )
      ''');
        });
  }

  Future<int> saveUser(UserModel user) async {
    var dbClient = await db;
    return await dbClient.insert("users", user.toMap());
  }

  Future<List<UserModel>> getUsers() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps = await dbClient.query("users");

    return maps.map((item) => UserModel(
        id: item['id'],
        name: item['name'],
        telepon: item['telepon'],
        deskripsi: item['deskripsi'])).toList();
  }

  Future<int> updateUser(UserModel user) async {
    var dbClient = await db;
    return await dbClient.update("users", user.toMap(),
        where: "id = ?", whereArgs: [user.id]);
  }

  Future<int> deleteUser(int id) async {
    var dbClient = await db;
    return await dbClient.delete("users", where: "id = ?", whereArgs: [id]);
  }
}
