import 'package:flutter/material.dart';
import 'package:flutter_app_layout/model/user.dart';
import 'package:flutter_app_layout/screen/Wrapper.dart';
import 'package:flutter_app_layout/screen/details_page.dart';
import 'package:flutter_app_layout/screen/my_home_page.dart';
import 'package:flutter_app_layout/services/database.dart';
import 'package:flutter_app_layout/services/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  //
   await CartPreferences.init();

  runApp(MyApp(
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: SQF_Provider.db.user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
      //  initialRoute: '/text_fields.dart',
        routes: {
         // '/': (context) => MyHomePage(),
      //    '/text_fields': (context) => MyTextFieldWidget(),
          '/details_page': (context) => Details_Page()
      //bad@hotmail.com
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}





