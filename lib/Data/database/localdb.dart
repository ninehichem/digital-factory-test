// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:digitalfactory/Data/models/eventModel.dart';

class Staticvar {
  static String table = "Eventtable";
  static String columnId = "columnid";
  static String activity = 'activity';
  static String accessibility = "accessibility";
  static String type = "type";
  static String participants = "participants";
  static String price = "price";
  static String key = "key";
  static String link = "link";
}

// const String table1 = "Eventtable";
// const String columnId1 = "columnid";
// const String activity1 = 'activity';
// const String accessibility1 = "accessibility";
// const String type1 = "type";
// const String participants1 = "participants";
// const String price1 = "price";
// const String key1 = "key";

class Event {
  int? id;
  late String activity;
  late String accessibility;
  late String type;
  String link = "";
  late String participants;
  late String price;
  late String key;

  Event();

  // convenience constructor to create a Word object
  Event.fromMap(Map<String, dynamic> map) {
    id = map[Staticvar.columnId];
    accessibility = map[Staticvar.accessibility];
    activity = map[Staticvar.activity];
    type = map[Staticvar.type];
    participants = map[Staticvar.participants];
    price = map[Staticvar.price];
    key = map[Staticvar.key];
    link = map[Staticvar.link] ?? "";
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      Staticvar.accessibility: this.accessibility,
      Staticvar.activity: this.activity,
      Staticvar.type: this.type,
      Staticvar.participants: this.participants,
      Staticvar.price: this.price,
      Staticvar.key: this.key,
      Staticvar.link: this.link,
      Staticvar.columnId: id
    };

    if (id != null) {
      map[Staticvar.columnId] = id;
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
      CREATE TABLE ${Staticvar.table} (
        ${Staticvar.columnId} INTEGER PRIMARY KEY,
        ${Staticvar.accessibility} TEXT NOT NULL,
        ${Staticvar.activity} TEXT NOT NULL,
        ${Staticvar.key} TEXT NOT NULL,
        ${Staticvar.participants} TEXT NOT NULL,
        ${Staticvar.link} TEXT NOT NULL,
        ${Staticvar.price} TEXT NOT NULL,
        ${Staticvar.type} TEXT NOT NULL
        )
    ''');
  }

  Future<int> insert(Event event) async {
    Database db = await database;

    int id = await db.insert(Staticvar.table, event.toMap());
    print('id === $id');
    return id;
  }

  Future<List?> queryAll() async {
    Database db = await database;
    List<Map> maps = await db.query(Staticvar.table, columns: [
      Staticvar.columnId,
      Staticvar.accessibility,
      Staticvar.activity,
      Staticvar.key,
      Staticvar.participants,
      Staticvar.link,
      Staticvar.price,
      Staticvar.type
    ]);

    if (maps.length > 0) {
      return maps.toList();
    }
    return [];
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete(Staticvar.table, where: '${Staticvar.columnId} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
