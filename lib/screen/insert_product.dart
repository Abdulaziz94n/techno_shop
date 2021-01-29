import 'package:flutter_app_layout/services/database.dart';
import 'package:flutter_app_layout/model/product.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InsertProduct extends StatefulWidget {
  InsertProduct();

  @override
  _MyTextFieldWidgetState createState() => _MyTextFieldWidgetState();
}

class _MyTextFieldWidgetState extends State<InsertProduct> {
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final imageController = TextEditingController();

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
        padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0, 0),
        child: Column(children: [
          // TextField(
          //
          //   controller: idController,
          //   decoration: InputDecoration(
          //       filled: true,
          //       fillColor: Colors.blue,
          //       border: InputBorder.none,
          //       hintText: 'your input ID'),
          // ),
          //SizedBox(height: 10),
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
          SizedBox(height: 15,),
          Center(
              child: FlatButton.icon(
                label: Text(''),
                icon: Icon(Icons.add , color: Colors.grey.shade800,),
                textColor: Colors.white,
                color: Colors.grey,
                onPressed: () {
                  setState(() {
                    String id = idController.text;
                    String name = nameController.text;
                    String description = descController.text;
                    String price = priceController.text;
                    String image = imageController.text;
                    var _pro = new Product(id,
                        name, description, int.tryParse(price), image);
                    SQF_Provider.db.insert_tofirestore(_pro);
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text('Product Added Successfully'),
                        );
                      },
                    );
                  });
                },
                // onPressed: () {
                //   return showDialog(
                //     context: context,
                //     builder: (context) {
                //       return AlertDialog(
                //         content: Text(myController3.text),
                //       );
                //     },
                //   );
                // },


              )),

          //

        ]),
      ),
    );
  }
}

_openUrl() {
  String url = 'https:google.com';
  launch(url);
}

//method 1
// GestureDetector(
// onTap: () {
// FocusScopeNode currentFocus = FocusScope.of(context);
// if (!currentFocus.hasPrimaryFocus) {
// currentFocus.unfocus();
// }
// },

// method 2
// onTap: () => FocusScope.of(context).unfocus(),
