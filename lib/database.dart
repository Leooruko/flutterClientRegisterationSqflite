import 'package:sqflite/sqflite.dart' as sql;


class SqlHelper{
  static Future<void> createTable(sql.Database database) async{
    await database.execute('''CREATE TABLE clients(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT,
      phone TEXT,
      ecosystem TEXT,
      sub_ecosystem TEXT,
      farm_size INTEGER,
      approved TEXT,
      attatchemnt TEXT,
      createdAT TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)'''
    );
  }
  static Future<sql.Database>db() async{
      return sql.openDatabase(
        'dbestech.db',
        version: 1,
        onCreate:(sql.Database database,int version)async{
          await createTable(database);
        }
      );
    }
    static Future<int> createItem(String name,String? phone,String ecosystem,String sub_ecosystem ,int farm_size)async{
      final db=await SqlHelper.db();
      final data={'name':name,'phone':phone,'ecosystem':ecosystem,'sub_ecosystem':sub_ecosystem,'farm_size':farm_size,'approved':'false','attatchemnt':'NULL'};
      final id= await db.insert('clients',data,
      conflictAlgorithm:sql.ConflictAlgorithm.replace);
      return id;
    }
    static Future<List<Map<String,dynamic>>> getItems() async{
      final db=await SqlHelper.db();
      return db.query('clients',orderBy: 'id');
    }
    static Future<List<Map<String,dynamic>>> getItemById(int id) async{
      final db=await SqlHelper.db();
      return db.query('clients', columns:['id','name','phone','ecosystem','sub_ecosystem','farm_size'] ,where:'id=?',whereArgs: [id]);
    }
    static Future<int> updateItem(int id,String name,String? phone,String ecosystem,String sub_ecosystem ,int farm_size) async{
      final db=await SqlHelper.db();
      final data={'name':name,'phone':phone,'ecosystem':ecosystem,'sub_ecosystem':sub_ecosystem ,'farm_size':farm_size,'createdAt':DateTime.now().toString()};
      final result=await db.update('clients',data,where:'id=?',whereArgs:[id]);
      return result;
    }
    static Future<int> delete(int id)async{
      final db=await SqlHelper.db();
      return db.delete('clients',where: 'id=?',whereArgs:[id]);
    }

    static Future<int> updateApproval(int id,String approval)async{
      final db=await SqlHelper.db();
      final result=db.rawUpdate(
        'UPDATE clients SET approved=? WHERE id=?',[approval,id] 
      );
      return result;
    }

    static Future<List<Map<String,dynamic>>> getApproved() async{
      final db=await SqlHelper.db();
      return db.query('clients',  where: '"approved" = ?', whereArgs:['true']);
    }

    static Future<List<Map<String,dynamic>>> getNotApproved() async{
      final db=await SqlHelper.db();
      return db.query('clients',  where: '"approved" = ?', whereArgs:['false']);
    }
    
    static Future<int>UpdateAttatchment(int id,String attatchmeny)async{
        final db=await SqlHelper.db();
        final result=db.rawUpdate(
        'UPDATE clients SET attatchemnt=? WHERE id=?',[attatchmeny,id] 
      );
      return result;
    }
}