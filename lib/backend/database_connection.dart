import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';


class DatabaseConnection{


  setDatabase() async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_projects_sqflite');
    var database = await openDatabase(path,version:1,onCreate:_onCreatingDatabase);

    return database;
  }
  _onCreatingDatabase(Database database, int version) async{
    
    await database.execute("CREATE TABLE Projects(id INTEGER PRIMARY KEY, name TEXT, createdBy TEXT, date TEXT)");
    
    await database.execute("CREATE TABLE Tasks(id INTEGER PRIMARY KEY, name TEXT, user TEXT, projectName TEXT, status TEXT)");

    await database.execute("CREATE TABLE Users(id INTEGER PRIMARY KEY, name TEXT, password TEXT, email TEXT, about TEXT)");

    await database.execute("CREATE TABLE Notfications(id INTEGER PRIMARY KEY, user TEXT, projectName TEXT, addedby TEXT)");


    
  }
}


  
 