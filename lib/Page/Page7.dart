import 'package:flutter/material.dart';
import 'package:flutter_project/Page/Page8.dart';
import 'package:flutter_project/Page/PageManual.dart';
//import 'package:flutter_project/Page/Page8.dart';

import '../Myconstant.dart';
import 'Page6.dart';
import 'Page5.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  double _values = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Myconstant.primary,
      appBar: AppBar(
        title: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Testing',
                  style: TextStyle(color: Myconstant.primary, fontSize: 25),
                  textAlign: TextAlign.center),
            ]),
        backgroundColor: Myconstant.light,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Adjust_sound();
            }));
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Myconstant.primary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_box),
            color: Myconstant.primary,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyProfile(); //myprofile
              }));
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Text(
            'IN PROGRESS.....',
            style: TextStyle(
                color: Myconstant.light,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //ICON Volumn down
                Icon(
                  Icons.volume_mute_rounded,
                  color: Myconstant.light,
                ),
                //SLIDER BAR
                Expanded(
                  child: Container(
                      child: SliderTheme(
                    data: SliderThemeData(
                        thumbColor: Colors.green,
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 10)),
                    child: Slider(
                      min: 0,
                      max: 100,
                      value: _values,
                      onChanged: (values) {},
                      activeColor: Myconstant.green,
                      inactiveColor: Myconstant.light,
                      label: _values.round().toString(),
                    ),
                  )),
                ),

                //ICON Volumn up
                Icon(
                  Icons.flag_rounded,
                  color: Myconstant.light,
                  size: 30,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_values != 100) {
                    _values += 10;
                  }
                });
              },
              child: Text(
                'Press when you hear sound',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                fixedSize: Size.fromRadius(100),
                onPrimary: Myconstant.primary,
                primary: Myconstant.light,
                padding: EdgeInsets.all(24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
