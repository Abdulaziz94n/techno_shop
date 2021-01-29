import 'package:flutter/material.dart';
import 'package:flutter_app_layout/model/user.dart';
import 'package:flutter_app_layout/screen/my_home_page.dart';
import 'package:provider/provider.dart';

import 'Auth_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print('Provider Check '+ user.toString());
    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return MyHomePage();
    }
  }
}