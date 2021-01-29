import 'package:flutter/material.dart';
import 'package:flutter_app_layout/model/product.dart';
import 'package:flutter_app_layout/widget/product_box.dart';
import 'package:flutter_app_layout/screen/details_page.dart';

class ProductBoxList extends StatelessWidget {
  List<Product> items;
  int itemsCount;

  ProductBoxList({Key key, this.items , this.itemsCount }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        //  using products list from fixed list
      ListView.builder(
      itemCount: items.length,
           itemBuilder: (context, index) => GestureDetector(
              child: Card(
                child: Container(
            color: Colors.black38,
                  child: ProductBox(item: items[index],),
               ),
              ),
              onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Details_Page(item: items[index])));
        },
      ),
    );
  }
}
