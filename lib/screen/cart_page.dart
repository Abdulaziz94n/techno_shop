import 'package:flutter/material.dart';
import 'package:flutter_app_layout/model/product.dart';
import 'package:flutter_app_layout/services/shared_preferences.dart';
import 'package:flutter_app_layout/widget/CartItem.dart';
import 'package:flutter_app_layout/widget/product_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  Product item;
  List<Product> items;

  CartPage({Key key, this.item, this.items}) : super(key: key);

  @override
  _CardState createState() => _CardState();
}

class _CardState extends State<CartPage> {
  String itemsNum = '';
  //int itemsNum = 0;
  List<Product> cartProducts = new List();
  Product p1 = Product.cartPageProduct(
      name: 'design laptop',
      image: "assets/design.jpg",
      description: 'product desc1',
      price: 3000,
      productCount: 5);

  Product p2 = Product.cartPageProduct(
      name: 'gaming laptop',
      image: "assets/monster.jpg",
      description: 'product desc2',
      price: 3200,
      productCount: 1);

  void initState() {
    itemsNum = CartPreferences.getItemsCounter();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    cartProducts = [p1, p2];
    itemsNum = '${cartProducts[0].productCount + cartProducts[1].productCount}';
    CartPreferences.setItemsCounter(itemsNum);
    return Scaffold(
        backgroundColor: Colors.grey.shade800,
        appBar: AppBar(
          title: Text('Cart Page'),
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.add_shopping_cart),
                label: Text(itemsNum.toString()),
                onPressed: () {
                  //  _signOut();
                })
          ],
        ),
        body: ListView.builder(
            itemCount: cartProducts.length,
            itemBuilder: (context, index) => cartProducts[index].productCount <=
                    0
                ? Container(
                    child: Text(''),
                  )
                : Card(
                    child: Container(
                        color: Colors.black38,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.20,
                              // width: 100,
                              height: 100,
                              child: Image.asset(
                                //  'https://images.macrumors.com/t/QWeDcROUG3WZfy71ZcsO1MsTZxI=/400x0/filters:quality(90)/article-new/2020/10/iphone12prodesignback.jpg?lossy',
                                cartProducts[index].image,
                                //iphone12.jpg
                                fit: BoxFit.fill,
                                // child: Image.network(
                                // "http://mis-web.com/flutter/netimages/" + item.image,
                                // fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    cartProducts[index].name,
                                  ),
                                  Text(cartProducts[index].description),
                                  GestureDetector(
                                    child: Text(
                                        cartProducts[index].price.toString()),
                                    onTap: () {
                                      Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text('im snack Bar')));
                                    },
                                  ),
                                  // MyTextFieldWidget()
                                ],
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.delete), onPressed: () {}),
                                IconButton(
                                    icon: Icon(
                                      Icons.add_circle_outlined,
                                      size: 20,
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        cartProducts[index].productCount++;
                                        this.itemsNum = cartProducts[index].productCount.toString();
                                        //saveCartItems();
                                      });
                                     // await CartPreferences.setItemsCounter(cartProducts[index].productCount.toString());

                                      //  await CartPreferences.setItemsCounter(cartProducts[index].productCount);
                                      print('++++++' +
                                          cartProducts[index]
                                              .productCount
                                              .toString());
                                    }),
                                Text(cartProducts[index]
                                    .productCount
                                    .toString()),
                                IconButton(
                                    icon: Icon(
                                      Icons.minimize,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      cartProducts[index].productCount--;
                                      setState(() {
                                        if (cartProducts[index].productCount <
                                            0) {
                                          cartProducts.remove(index);
                                        } else {}
                                      });

                                      print('------' +
                                          cartProducts[index]
                                              .productCount
                                              .toString());

                                      // await CartPreferences.setBirthday(itemsNum);

                                      // saveCartItems();
                                    }),
                              ],
                            ),
                          ],
                        )))));
    // child: CartItem(
    //   item: IteminCard,itemNum: widget.itemsCount ,
    // ),

    // ListView.builder(
    //   itemCount: items.length,
    //   itemBuilder: (context, index) => GestureDetector(
    //     child: Card(
    //       child: Container(
    //         color: Colors.black38,
    //         child: ProductBox(item: items[index],),
    //       ),
    //     ),
    //     onTap: () {
    //       Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //               builder: (context) => Details_Page(item: items[index])));
    //     },
    //   ),
    // );
  }

  // void saveCartItems() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setInt('itemsNum', widget.itemsCount);
  //   print('items Saved Saved Saved ');
  // }

  // void loadCartItems() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.getInt('itemsNum');

  // }

  loadCartItems() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int itemsCount = pref.getInt('itemsNum');
    print('LoadCartItems triggered = True');
    return itemsCount;
  }
}
