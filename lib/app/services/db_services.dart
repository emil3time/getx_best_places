import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as p;

class DBServices {
  static Future<sql.Database> dataBase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(p.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
  }

  static Future<void> insertData(String table, Map<String, Object> data) async {
    final db = await DBServices.dataBase();

    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

 static Future<List<Map<String, dynamic>>> queryData(String table) async {
    final db = await DBServices.dataBase();
    return db.query(table);
  }
}
