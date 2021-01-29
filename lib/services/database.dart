import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_layout/model/product.dart';
import 'package:flutter_app_layout/model/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SQF_Provider {
  final String id;

  final res = Firestore.instance.collection('product').document().documentID;

  SQF_Provider({this.id});

  SQF_Provider._({this.id});

  static SQF_Provider db = new SQF_Provider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;
    else
      return await initDatabase();
  }

  Future<Database> initDatabase() async {
    var app_path = await getApplicationDocumentsDirectory();
    String final_path = join(app_path.path, 'myDB.db');
    print(final_path);
    return openDatabase(
      final_path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE Product ("
            "id INTEGER PRIMARY KEY,"
            "name TEXT,"
            "description TEXT,"
            "price INTEGER,"
            "image TEXT"
            ")");
        await db.execute(
            "INSERT INTO Product ('id', 'name', 'description', 'price', 'image') values (?, ?, ?, ?, ?)",
            [
              2,
              "Pixel",
              "Pixel is the most feature phone ever",
              800,
              "pixel.jpg"
            ]);
        await db.execute(
            "INSERT INTO Product ('id', 'name', 'description', 'price', 'image') values (?, ?, ?, ?, ?)",
            [
              3,
              "Laptop",
              "Laptop is most productive development tool",
              2000,
              "laptop.jpg"
            ]);
        await db.execute(
            "INSERT INTO Product ('id', 'name', 'description', 'price', 'image') values (?, ?, ?, ?, ?)",
            [
              4,
              "Tablet",
              "Laptop is most productive development tool",
              1500,
              "tablet.jpg"
            ]);
        await db.execute(
            "INSERT INTO Product ('id', 'name', 'description', 'price', 'image') values (?, ?, ?, ?, ?)",
            [
              5,
              "Pendrive",
              "Pendrive is useful storage medium",
              100,
              "pendrive.jpg"
            ]);
        await db.execute(
            "INSERT INTO Product ('id', 'name', 'description', 'price', 'image') values (?, ?, ?, ?, ?)",
            [
              6,
              "Floppy Drive",
              "Floppy drive is useful rescue storage medium",
              20,
              "floppydisk.jpg"
            ]);
      },
    );
  }

  Future<List<Product>> getSqfProducts() async {
    var db = await database;
    List<Map> result = await db.query("Product",
        columns: ["id", "name", "description", "price", "image"],
        orderBy: "id ASC");
    List<Product> products = new List();

    result.forEach((map_row) {
      Product pro = Product.fromMap(map_row);
      products.add(pro);
    });
    return products;
  }

  //Create user from FireBaseUser

  User _userFromFireBase(FirebaseUser user){
    return user != null ? User(id: user.uid ) : null;
  }

  insert(Product product) async {
    final db = await database;
    var maxIdResult =
        await db.rawQuery("SELECT MAX(id)+1 as last_inserted_id FROM Product");
    var id = maxIdResult.first["last_inserted_id"];
    var result = await db.rawInsert(
        "INSERT Into Product (id, name, description, price, image)"
        " VALUES (?, ?, ?, ?, ?)",
        [id, product.name, product.description, product.price, product.image]);
    return result;
  }

  Stream<QuerySnapshot> getProducts_FireStore({String uid}) {
    Firestore.instance
        .collection('product')
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      querySnapshot.documents ;
         // .forEach((document) => print(document.data.toString()));
    });

    return Firestore.instance.collection('product').snapshots();
  }

  Stream<User> get user {
    return FirebaseAuth.instance.onAuthStateChanged
   // .map((FirebaseUser user) => _userFromFireBase(user));
    .map(_userFromFireBase);
  }

  insert_tofirestore(Product pro) async {
    await Firestore.instance
        .collection('product')
        .add(pro.toMap())
        .then((value) {
     // print(value.documentID);
      // Firestore.instance.collection("users").document(value.documentID).updateData(data)
    });
  }

  Future update_FirebaseProduct(Product pro) async {
    return await Firestore.instance
        .collection('product')
        .document(pro.id)
        .setData({
      'id': pro.id,
      'name': pro.name,
      'description': pro.description,
      'price': pro.price,
      'image': pro.image,
    });
  }

  Future delete_FirebaseProduct(Product pro) async {
    await Firestore.instance.collection('product').document(pro.id).delete();
  }

  static Future addPost(Product post) async {
    try {
      await Firestore.instance.collection('product').add(post.toMap());
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
