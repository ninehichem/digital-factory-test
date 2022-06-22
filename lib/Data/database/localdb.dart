import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:digitalfactory/Data/models/eventModel.dart';

const String table = "_table";
const String columnId = "columnid";
const String activity = 'activity';
const String accessibility = "accessibility";
const String type = "type";
const String participants = "participants";
const String price = "price";
const String key = "key";

class Event {
  int? id;
  late String activity;
  late String accessibility;
  late String type;
  late String participants;
  late String price;

  late String key;

  Event(
      {required this.accessibility,
      required this.activity,
      required this.key,
      required this.participants,
      required this.price,
      required this.type});

  // convenience constructor to create a Word object
  Event.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    this.accessibility = map[accessibility];
    this.activity = map[activity];
    this.type = map[type];
    this.participants = map[participants];
    this.price = map[price];
    this.key = map[key];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      accessibility: this.accessibility,
      activity: this.activity,
      type: this.type,
      participants: this.participants,
      price: this.price,
      key: this.key,
    };

    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

class DataBaseHelper {
  static final _databaseName = "event.db";
  static final _databaseVersion = 1;
  DataBaseHelper();

  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {

    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $accessibility TEXT NOT NULL,
        $activity TEXT NOT NULL,
        $key TEXT NOT NULL,
        $participants TEXT NOT NULL,
        $price TEXT NOT NULL,
        $type TEXT NOT NULL
        )
    ''');

 
  }

  Future<int> insert(Event event) async {
    Database db = await database;
    int id = await db.insert(table, event.toMap());
    return id;
  }

  Future<List?> queryAll() async {
    Database db = await database;
    List<Map> maps = await db.query(table, columns: [
      columnId,
      accessibility,
      activity,
      key,
      participants,
      price,
      type
    ]);
    if (maps.length > 0) {
      return maps.toList();
    }
    return null;
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete(table, where: '_id = ?', whereArgs: [id]);
  }
}
