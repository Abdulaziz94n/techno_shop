import 'package:flutter_app_layout/services/database.dart';
import 'package:flutter_app_layout/model/product.dart';
import 'package:flutter/material.dart';

class UpdateProduct extends StatefulWidget {
  final Product item;
  final String id;

  UpdateProduct({Key key, this.item, this.id}) : super(key: key);

  @override
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  TextEditingController idController;
  TextEditingController nameController;
  TextEditingController descController;
  TextEditingController priceController;
  TextEditingController imageController;

  // var idController = TextEditingController();
  // var nameController = TextEditingController();
  // var descController = TextEditingController();
  // var priceController = TextEditingController();
  // var imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    idController = new TextEditingController(text: widget.item.id);
    nameController = new TextEditingController(text: widget.item.name);
    descController = new TextEditingController(text: widget.item.description);
    priceController =
        new TextEditingController(text: widget.item.price.toString());
    imageController = new TextEditingController(text: widget.item.image);
  }

  @override
  Widget build(BuildContext context) {
    // String id = idController.text;
    // String name = nameController.text;
    // String description = descController.text;
    // String price = priceController.text;
    // String image = imageController.text;

    return Scaffold(
        appBar: AppBar(title: Text('Profile Page')),
        backgroundColor: Colors.grey.shade800,
        body: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0, 0),
            child: Column(children: [
              SizedBox(height: 10),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey,
                    border: InputBorder.none,
                    hintText: 'your input name'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: descController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey,
                    border: InputBorder.none,
                    hintText: 'your input desc'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey,
                    border: InputBorder.none,
                    hintText: 'your input price'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: imageController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey,
                    border: InputBorder.none,
                    hintText: 'your input image'),
              ),
              SizedBox(height: 15),
              FlatButton.icon(
                label: Text(''),
                icon: Icon(
                  Icons.edit,
                  color: Colors.grey.shade900,
                ),
                textColor: Colors.white,
                color: Colors.grey,
                onPressed: () {
                  setState(() {
                    String id = idController.text;
                    String name = nameController.text;
                    String description = descController.text;
                    String price = priceController.text;
                    String image = imageController.text;

                    var _pro = new Product(
                        id, name, description, int.tryParse(price), image);
                    SQF_Provider.db.update_FirebaseProduct(_pro);
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(
                            'Edited Successfully',
                          ),
                        );
                      },
                    );
                  });
                },

                //
              ),
            ])));
  }
}
