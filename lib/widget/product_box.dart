import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_layout/model/user.dart';
import 'package:flutter_app_layout/screen/Auth_screen.dart';
import 'package:flutter_app_layout/screen/cart_page.dart';
import 'package:flutter_app_layout/screen/insert_product.dart';
import 'package:flutter_app_layout/screen/sign_in.dart';
import 'package:flutter_app_layout/screen/update_product.dart';
import 'package:flutter_app_layout/services/database.dart';
import 'package:provider/provider.dart';
import 'star.dart';
import 'package:flutter_app_layout/model/product.dart';

class ProductBox extends StatefulWidget {
  Product item;
  int itemsCount;


  ProductBox({Key key, this.item , this.itemsCount}) : super(key: key);

  @override
  _ProductBoxState createState() => _ProductBoxState();
}

class _ProductBoxState extends State<ProductBox> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    List<Product> cardItems = new List<Product>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.20,
          // width: 100,
          height: 100,
          child: Image.asset(
            //  'https://images.macrumors.com/t/QWeDcROUG3WZfy71ZcsO1MsTZxI=/400x0/filters:quality(90)/article-new/2020/10/iphone12prodesignback.jpg?lossy',
            "assets/" + widget.item.image,
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
              Star(),
              // MyTextFieldWidget()
            ],
          ),
        ),
        Column(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateProduct(
                          item: widget.item,
                        ),
                      ));
                }),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  SQF_Provider.db.delete_FirebaseProduct(widget.item);
                }),
            IconButton(
                icon: Icon(Icons.add_shopping_cart),
                onPressed: () {
                  if (user != null) {
                  cardItems.add(widget.item);
                  print ('added product name is ' + widget.item.name);
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Authenticate()));
                  }
                }

              //   user != null
              //       ?
              //   Navigator.push
              //     (context, MaterialPageRoute(builder: (context)=> CardPage(item: item,),))
              //       : Navigator.push
              //     (context, MaterialPageRoute(builder: (context)=> Authenticate()));
              //  }
              // )
              //
            )
          ],
        )
      ],
    );
  }
}
