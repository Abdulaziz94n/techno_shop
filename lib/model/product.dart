import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Product {
  String id;
  String name;
  String description;
  int price;
  String image;
  int productCount;

  Product(this .id ,this.name, this.description, this.price, this.image);

  Product.cartPageProduct({this.price, this.description,this.image,this.name,this.id, this.productCount}) ;

  static List<Product> getProducts() {
    List<Product> p_List = <Product>[];
    p_List.add(Product(
      '1',
      'Iphone',
      'best seller',
      1000,
      'assets/iphone.jpg',
    ));
    p_List.add(Product(
      '2',
      'Tablet',
      'best prod',
      600,
      'assets/tablet.jpg',
    ));
    p_List.add(Product(
      '3',
      'Tablet',
      'best prod',
      600,
      'assets/floppydisk.jpg',
    ));
    return p_List;
  }

  static Future<List<Product>> fetchProductsOnline() async {
    final response = await http.get('https://mis-web.com/myapi.php');
    if (response.statusCode == 200) {
      return parseProducts(response.body);
    } else {
      throw Exception('Unable to fetch prodcut from API');
    }
  }

  factory Product.fromMap(Map<String, dynamic> data) {
    return Product(
      data['id'],
      data['name'],
      data['description'],
      data['price'],
      data['image'],
    );
  }

  static List<Product> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Product>((json) => Product.fromMap(json)).toList();
  }
  static Stream < List<Product> > fetchProductStream () async*{
    StreamController < List<Product> > mystream = StreamController < List<Product> >() ;
    final response = await http.get('https://mis-web.com/myapi.php');

    yield parseProducts(response.body);
  }

  Map<String , dynamic> toMap(){
    return {
      'id': id,
      'name':name,
      'description': description,
      'price': price,
      'image': image
    };
  }

}
