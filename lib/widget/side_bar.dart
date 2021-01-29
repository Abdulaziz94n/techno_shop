import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_layout/screen/login.dart';
import 'package:flutter_app_layout/screen/insert_product.dart';
import 'package:flutter_app_layout/screen/my_home_page.dart';
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

class NavDrawer extends StatelessWidget {
  // static const platform = const MethodChannel('com.mis.dev/browser');
  //
  // Future<void> _openBrowser() async {
  //   try {
  //     final int result = await platform.invokeMethod('openBrowser', <String, String>{
  //       'url': "https://mis-web.com"
  //     });
  //   }
  //   on PlatformException catch (e) {
  //     // Unable to open the browser print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.input),
              title: Text('Welcome'),
              onTap: () => {Navigator.pop(context)},
            ),
            ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('Add Product'),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InsertProduct()),
                )
              },
            ),
            ListTile(
              leading: Icon(Icons.border_color),
              title: Text('Change User'),
              onTap: () {
                _signOut();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Login()),
                // )
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: _signOut
            ),
          ],
        ),
      ),
    );
  }
}

_signOut() async {
  await FirebaseAuth.instance.signOut();
  print('Successfully Signed Out');
  //  Navigator.pop(context);
}

_openUrl() {
  String url= 'https:google.com';
  launch(url);
}

_launchURL() async {
  const url = 'https://flutter.io';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}