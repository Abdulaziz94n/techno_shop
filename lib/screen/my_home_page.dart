import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_layout/model/product.dart';
import 'package:flutter_app_layout/screen/cart_page.dart';
import 'package:flutter_app_layout/services/database.dart';
import 'package:flutter_app_layout/services/shared_preferences.dart';
import 'package:flutter_app_layout/widget/ProductBoxList.dart';
import 'package:flutter_app_layout/widget/side_bar.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
 // Product item ;
  MyHomePage({Key key}) : super(key: key);

  //final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _val = 0;

  AnimationController animationController;
  Animation animation;
  double size;

  @override
  void initState() {
   //String _val = CartPreferences.getItemsCounter();

    animationController =
        AnimationController(duration: const Duration(seconds: 12), vsync: this);
    CurvedAnimation curved =
        CurvedAnimation(parent: animationController, curve: Curves.bounceOut);
    animation = Tween<double>(begin: 100.0, end: 300.0).animate(curved);
    animation.addListener(() {
      setState(() {
        size = animation.value;
      });
    });
    // animationController.forward();               UN-HASH THIS LINE FOR ANIMATION
    super.initState();
  }

  Future<http.Response> fetchWebsite(String url) {
    Future<http.Response> content = http.get(url);
    content.then((res) {
      print(res.body);
    });
    return content;
  }

  @override
  Widget build(BuildContext context) {
    final val = CartPreferences.getItemsCounter();
    //  List<Product> product_list = Product.getProducts();

    return Scaffold(
      backgroundColor: Colors.grey.shade800,

      appBar: AppBar(
        //backgroundColor: Colors.grey,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            return NavDrawer();
          },
        ),
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.add_shopping_cart),
              label: Text('$_val' =='0' ? '' + CartPreferences.getItemsCounter().toString() : '!!'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CartPage()));
              //  _signOut();
              })
        ],
        title: Text('Home Page'),
      ),
      drawer: NavDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Center(
          child: StreamBuilder<QuerySnapshot>(
              stream: SQF_Provider().getProducts_FireStore(),
              builder: (context, snapshot) {
                if (snapshot.hasData == true) {
                  List<DocumentSnapshot> documents = snapshot.data.documents;
                  List<Product> items = List<Product>();
                  for (var i = 0; i < documents.length; i++) {
                    DocumentSnapshot document = documents[i];
                    var p = Product.fromMap(document.data);
                    p.id = document.documentID;
                    items.add(p);
                  }
                  //return Text(snapshot.data.documents.toString() ) ;
                  return ProductBoxList(items: items , );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }


  isLogged() {
    FirebaseAuth.instance.currentUser().then((loggedUser) {
      if (loggedUser != null) {
        print('welcome' + loggedUser.email);
      } else {
        print('Please Login');
      }
    });
  }

  _signOut() async {
    await FirebaseAuth.instance.signOut();
    print('Successfully Signed Out');
    //  Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

// Center(
//   child: ListView.builder(
//     itemCount: product_list.length,
//     itemBuilder: (context, ind) => GestureDetector(
//       child: Container(
//        // height: size,
//         child: ProductBox(item: product_list[ind]),
//       ),
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => Details_Page(
//                     item: product_list[ind],
//                   )),
//         );
//       },
//     ),
//     // mainAxisAlignment: MainAxisAlignment.center,
//     // children: <Widget>[
//     //   ProductBox(item: p_List[0]),
//     //   ProductBox(item: p_List[1]),
//   ),
//
// ),

//     FutureBuilder<List<Product>>(
//   future: SQF_Provider.db.getSqfProducts(),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return CircularProgressIndicator();
//     }
//     if (snapshot.connectionState == ConnectionState.done) {
//       return ProductBoxList(items: snapshot.data);
//     }
//     return Text('finished');
//   },
// ),

// FutureBuilder<List<Product>>(
//   future: Product.fetchProductsOnline(),
//   builder: (context, snapshot) {
//     if(snapshot.connectionState==ConnectionState.waiting) {
//       return CircularProgressIndicator();
//     }
//     if(snapshot.connectionState==ConnectionState.done) {
//       return ProductBoxList(items: snapshot.data);
//
//     }
//     return Text('finished');
//   },
// ),

//  Turning Stream to Future

// StreamBuilder < List<Product> >(
//   stream: Product.fetchProductStream(),
//   builder: (context, snapshot){
//     return ProductBoxList(items: snapshot.data);
//   },
// )
