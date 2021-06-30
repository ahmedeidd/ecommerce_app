/*import 'package:ecommerce_app_eid/models/favorite_product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteProductsDbHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return _db;
  }

  Future<Database> initDatabase() async {
    //Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(await getDatabasesPath(), 'favoriteproducts.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          """
        CREATE TABLE favoriteproducts (_id INTEGER PRIMARY KEY, name varchar(500) NOT NULL,
        price INTEGER, imageUrl varchar(500) NOT NULL, category varchar(500) NOT NULL, details varchar(500) NOT NULL, __v INTEGER)
        """,
        );
      },
    );
    return db;
  }

  Future<List<FavoriteProduct>> getFavoriteProducts() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(
      'favoriteproducts',
      columns: [
        '_id',
        'name',
        'price',
        'imageUrl',
        'category',
        'details',
        '__v'
      ],
    );
    List<FavoriteProduct> favoriteProducts = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        favoriteProducts.add(FavoriteProduct.fromMap(maps[i]));
      }
    }
    return favoriteProducts;
  }

  Future<FavoriteProduct> add(FavoriteProduct favoriteProduct) async {
    var dbClient = await db;
    favoriteProduct.id = await dbClient.insert(
      'favoriteproducts',
      favoriteProduct.toMap(),
    );
    return favoriteProduct;
  }

  Future<bool> favoriteProductExists(int id, String name) async {
    var dbClient = await db;
    var queryResult = await dbClient.rawQuery(
      "SELECT * FROM favoriteproducts WHERE name = '$name' AND  _id = '$id'",
    );
    bool recordExists = queryResult.isNotEmpty;
    return recordExists;
  }

  Future<int> delete(int id, String name) async {
    var dbClient = await db;
    return await dbClient.delete(
      'favoriteproducts',
      where: '_id = ? AND name = ?',
      whereArgs: [id, name],
    );
  }

  Future<void> close() async {
    var dbClient = await db;
    dbClient.close();
    _db = null;
  }
}
*/
