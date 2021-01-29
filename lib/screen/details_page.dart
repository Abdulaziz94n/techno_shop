import 'package:flutter/material.dart';
import 'package:flutter_app_layout/model/product.dart';
import 'package:flutter_app_layout/screen/insert_product.dart';
import 'package:flutter_app_layout/screen/update_product.dart';
import 'package:flutter_app_layout/widget/star.dart';

class Details_Page extends StatelessWidget {
  Product item;

  Details_Page({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,

      appBar: AppBar(
        title: Text('Details_Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 300,
            child: Image.asset(
              "assets/" + item.image,
              fit: BoxFit.fill,
              // child: Image.network(
              //   "http://mis-web.com/flutter/netimages/" + item.image,
              //   fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            child: Text(
              'Product Name: ' + item.name, style: TextStyle(
              color: Colors.white , fontSize: 20,
            ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Product Description: ' + item.description, style: TextStyle(
            color: Colors.white , fontSize: 20,
          ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.0),
          Text('Product Price: ' + item.price.toString(),style: TextStyle(
            color: Colors.white , fontSize: 20,
          ),),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(80.0, 0.0, 0.0, 0.0),
            child: Star(),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            child: FloatingActionButton(
              child: Icon(Icons.edit),
              onPressed: () {
                //Navigator.pushNamed(context, '/text_fields');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateProduct(
                            item: item,
                          )),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
