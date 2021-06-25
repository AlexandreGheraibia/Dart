import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_music/ScreenData.dart';
import 'dart:io';


class DBManager{
  Database db;
  Future<void> init() async {
    var databasesPath = await getDatabasesPath();
    print(databasesPath.toString());
    var path= join(databasesPath, "coran.db");
  // Check if the database exists
    if (!await databaseExists(path)) {
  // Should happen only the first time you launch your application
      print("Creating new copy from asset");
  // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
  // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "coran.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

  // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

    } else {
      print("Opening existing database");

    }
    // open the database
    db = await openDatabase(path, readOnly: true);
  }

  Future<List<DataListItem>> getVerset() async{
    int sId = 1;
    int vId = 1;
    String sourateName;
    final List<DataListItem> coran = [];
    List<DataItem> versets = [];
    List<Map<String, Object>> records = await db.rawQuery('SELECT * FROM arabic as a '
                                                        'LEFT JOIN arabic_chapter as ac '
                                                        'ON a.SuraID = ac.SuraID;');

    for(Map<String, Object> lines in records){
        lines.forEach((key, value)  {
          switch(key){
            case "SuraID":
                if(int.parse(value) != sId){
                  coran.add(DataListItem("${sId}. ${sourateName}",versets));
                  versets=[];
                  sId=int.parse(value);
                }
              break;
            case "VerseID":
                vId = int.parse(value);
              break;
            case "SuraText":
                sourateName=value;
              break;
            case "AyahText":
                versets.add(DataItem('${vId}. ${value}',value));
              break;
          }
        });
    }
    coran.add(DataListItem("${sId}). ${sourateName}",versets));
    return coran;
  }

  Future close() async => db.close();

}


