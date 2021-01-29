import 'package:flutter/material.dart';
import 'package:flutter_app_layout/model/product.dart';
import 'package:flutter_app_layout/screen/cart_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartItem extends StatefulWidget {
  Product item;
  int itemNum ;
  CartItem({Key key, this.item , this.itemNum}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  //int itemNum;

  @override
  void initState() {
    widget.itemNum = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadCartItems();
    saveCartItems();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.20,
          // width: 100,
          height: 100,
          child: Image.asset(
            //  'https://images.macrumors.com/t/QWeDcROUG3WZfy71ZcsO1MsTZxI=/400x0/filters:quality(90)/article-new/2020/10/iphone12prodesignback.jpg?lossy',
            "assets/" + '${widget.item.image}',
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
              Text('Name :' + widget.item.name),
              Text('Description :' + widget.item.description),
              GestureDetector(
                child: Text('Price :' + widget.item.price.toString()),
                onTap: () {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('im snack Bar')));
                },
              ),
              // MyTextFieldWidget()
            ],
          ),
        ),
        Column(
          children: <Widget>[
            IconButton(icon: Icon(Icons.delete), onPressed: () {}),
            IconButton(
                icon: Icon(
                  Icons.add_circle_outlined,
                  size: 20,
                ),
                onPressed: () async {
                  setState(() {
                    widget.itemNum++;
                    saveCartItems();
                  });

                  print('++++++' + widget.itemNum.toString());
                }),
            Text(widget.itemNum.toString()),
            IconButton(
                icon: Icon(
                  Icons.minimize,
                  size: 20,
                ),
                onPressed: () async {
                  setState(() {
                    widget.itemNum--;
                  });
                  saveCartItems();
                }),
          ],
        ),
      ],
    );
  }

  void saveCartItems() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('itemsNum', widget.itemNum);
    print('items Saved Saved Saved ');
  }

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
