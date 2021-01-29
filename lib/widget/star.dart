import 'package:flutter/material.dart';

class Star extends StatefulWidget {
  @override
  _StarState createState() => _StarState();
}
//3 functions for rating , rating 1 , rating 2 , rating 3

class _StarState extends State<Star> {
  bool ifNotBordered1 = true;
  bool ifNotBordered2 = true;
  bool ifNotBordered3 = true;

  int rating = 0;

  // void changeStar() {
  //   setState(() {
  //     ifNotBordered1 = !ifNotBordered1 ;
  //   });
  // }

// ||
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
        mainAxisAlignment: MainAxisAlignment.start  ,
        children: <Widget>[
          FlatButton.icon(
              icon: rating == 0 ? Icon(Icons.star_border, color: Colors.white,) : Icon(Icons.star, color: Colors.white,) ,
              label: Text(''),
              onPressed: () {
                setState(() {
                  rating = 1;
                  //  ifNotBordered1 = !ifNotBordered1;
                  //   print(ifNotBordered1);
                  // if (ifNotBordered) {
                  //   Icon(Icons.star_border);
                  // } else
                  //   Icon(Icons.star);
                });
              }),
          FlatButton.icon(
              icon: rating == 0 || rating == 1
                  ? Icon(Icons.star_border, color: Colors.white,)
                  : Icon(Icons.star, color: Colors.white,),
              label: Text(''),
              onPressed: () {
                setState(() {
                  rating = 2;
                  //   ifNotBordered2 = !ifNotBordered2;
                  //   print(ifNotBordered2);
                  // if (ifNotBordered) {
                  //   Icon(Icons.star_border);
                  // } else
                  //   Icon(Icons.star);
                });
              }),
          FlatButton.icon(
              icon: rating == 0 || rating == 1 || rating == 2
                  ? Icon(Icons.star_border, color: Colors.white,)
                  : Icon(Icons.star ,color: Colors.white,),
              label: Text(''),
              onPressed: () {
                setState(() {
                  rating = 3;
                  //      ifNotBordered3 = !ifNotBordered3;
                  //      print(ifNotBordered3);
                });
              })
        ],
        ),

    );


    return Row(
      children: <Widget>[
        FlatButton.icon(
            icon: rating == 0 || ifNotBordered1
                ? Icon(Icons.star_border)
                : Icon(Icons.star),
            label: Text(''),
            onPressed: () {
              setState(() {
                rating = 1;
                ifNotBordered1 = !ifNotBordered1;
                print(ifNotBordered1);
                // if (ifNotBordered) {
                //   Icon(Icons.star_border);
                // } else
                //   Icon(Icons.star);
              });
            }),
        FlatButton.icon(
            icon: rating == 0 || rating == 1 || ifNotBordered2
                ? Icon(Icons.star_border)
                : Icon(Icons.star),
            label: Text(''),
            onPressed: () {
              setState(() {
                rating = 2;
                ifNotBordered2 = !ifNotBordered2;
                print(ifNotBordered2);
                // if (ifNotBordered) {
                //   Icon(Icons.star_border);
                // } else
                //   Icon(Icons.star);
              });
            }),
        FlatButton.icon(
            icon: rating == 0 || rating == 1 || rating == 2 || ifNotBordered3
                ? Icon(Icons.star_border)
                : Icon(Icons.star),
            label: Text(''),
            onPressed: () {
              setState(() {
                rating = 3;
                ifNotBordered3 = !ifNotBordered3;
                print(ifNotBordered3);
              });
            })
      ],
    );

    // return Row(
    //   children: <Widget>[
    //     FlatButton.icon(
    //
    //         icon: rating == 0 ?  Icon(Icons.star_border)  : Icon(Icons.star)
    //
    //         , label: Text(''), onPressed: () {
    //           setState(() {
    //
    //            rating = StarIcon3() ;
    //           });
    //     })
    //   ],
    // );
  }
}
int StarIcon1() {
  return 1;
}

int StarIcon2() {
  return 2;
}

int StarIcon3() {
  return 3;
}

