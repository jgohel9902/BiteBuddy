import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:bitebuddy/models/restaurant.dart';

class DBService {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'bitebuddy.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bookmarks (
        id TEXT PRIMARY KEY,
        name TEXT,
        address TEXT,
        photo TEXT,
        rating REAL,
        lat REAL,
        lng REAL
      )
    ''');
  }

  static Future<void> addBookmark(Restaurant r) async {
    final dbClient = await db;
    await dbClient.insert('bookmarks', {
      'id': r.id,
      'name': r.name,
      'address': r.address,
      'photo': r.photoReference,
      'rating': r.rating,
      'lat': r.lat,
      'lng': r.lng,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> removeBookmark(String id) async {
    final dbClient = await db;
    await dbClient.delete('bookmarks', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> updateBookmark(Restaurant r) async {
    final dbClient = await db;
    await dbClient.update(
      'bookmarks',
      {
        'name': r.name,
        'address': r.address,
        'photo': r.photoReference,
        'rating': r.rating,
        'lat': r.lat,
        'lng': r.lng,
      },
      where: 'id = ?',
      whereArgs: [r.id],
    );
  }

  static Future<List<Restaurant>> getBookmarks() async {
    final dbClient = await db;
    final maps = await dbClient.query('bookmarks');

    return List.generate(maps.length, (i) {
      final data = maps[i];
      return Restaurant(
        id: data['id'] as String,
        name: data['name'] as String,
        address: data['address'] as String,
        photoReference: data['photo'] as String,
        rating: (data['rating'] as num).toDouble(),
        lat: (data['lat'] as num).toDouble(),
        lng: (data['lng'] as num).toDouble(),
      );
    });
  }
}
