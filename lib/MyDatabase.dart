import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class MyDatabase{
  Future<Database> initDatabase() async {
    return await openDatabase(
        join(await getDatabasesPath(),'student_info'),
        version: 1,
        onCreate: (db, version) async {
          return await db.execute("CREATE TABLE STUDENT(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT)");
        },
    );
  }

  Future<List<Map<String,dynamic>>> getAllStudent() async {
    Database db=await initDatabase();
    var res=await db.rawQuery("select * from STUDENT");
    return res;
  }

  Future<int> insertStudent(String name) async {
    Database db=await initDatabase();
    Map<String,dynamic> map={};
    map['name']=name;
    var res=await db.insert("STUDENT", map);
    return res;
  }

  Future<void> deleteStudent(int id) async {
    Database db=await initDatabase();
    await db.delete("STUDENT",where: "id=?",whereArgs: [id]);
  }

  Future<int> editStudent(int id,String name) async {
    Database db=await initDatabase();
    Map<String,dynamic> map={};
    map['name']=name;
    var res=await db.update("STUDENT", map,where: "id=?",whereArgs: [id]);
    return res;
  }
}