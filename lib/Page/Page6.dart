import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/Page/Page4.dart';
import 'package:flutter_project/Page/Page5.dart';
import 'package:flutter_project/Page/PageLeft.dart';
import 'package:volume_control/volume_control.dart';

import '../Myconstant.dart';
import 'Page7.dart';
import 'PageRight.dart';

class Adjust_sound extends StatefulWidget {
  const Adjust_sound({Key? key}) : super(key: key);

  @override
  _Adjust_soundState createState() => _Adjust_soundState();
}

class _Adjust_soundState extends State<Adjust_sound> {
  void initState() {
    super.initState();
    initVolumeState();
  }

  //init volume_control plugin
  Future<void> initVolumeState() async {
    final double value = await VolumeControl.volume;
    setState(() {
      _val = value;
      print(_val);
    });
  }

  double _val = 0;
  Timer? timer;
  bool pressed = false;
  Future<double> vol = VolumeControl.volume;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Myconstant.primary,
        appBar: AppBar(
          centerTitle: true,
          title: new Center(
            child: new Text('Setting Environment',
                style: TextStyle(color: Myconstant.primary, fontSize: 25),
                textAlign: TextAlign.center),
          ),
          backgroundColor: Myconstant.light,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyHomePage(title: '');
              }));
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Myconstant.primary,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.account_circle_outlined,
                size: 30,
              ),
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
            Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Container(
                    height: 50,
                    //width: double.infinity,
                    decoration: BoxDecoration(
                      color: Myconstant.primary,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Find A Quite Place',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Myconstant.light),
                    )),
                SizedBox(
                  height: 50,
                ),
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Myconstant.primary,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Please set master volumn on device at 50 %',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Myconstant.light),
                    )),
              ],
            ),
            SizedBox(height: 25),
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
                        value: _val * 100,
                        min: 0,
                        max: 100,
                        divisions: 10,
                        label: '${_val * 100}',
                        onChanged: (val) {
                          _val = val * 0.01;
                          setState(() {});
                          if (timer != null) {
                            timer!.cancel();
                          }

                          //use timer for the smoother sliding
                          timer = Timer(Duration(milliseconds: 100), () {
                            VolumeControl.setVolume(val * 0.01);
                          });

                          VolumeControl.setVolume(val * 0.01);
                          print("val:${val * 0.01}");
                          print("val no multiply: ${val}");
                          if (_val == 0.5) {
                            pressed = true;
                          } else {
                            pressed = false;
                          }
                        },
                        activeColor: Myconstant.green,
                        inactiveColor: Myconstant.light,
                      ),
                    )),
                  ),

                  //ICON Volumn up
                  Icon(
                    Icons.volume_up_rounded,
                    color: Myconstant.light,
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Column(
              children: <Widget>[
                FlatButton(
                  padding: const EdgeInsets.all(5.0),
                  color: pressed
                      ? Color.fromRGBO(98, 148, 96, 1)
                      : Myconstant.darkgray,
                  child: Text(
                    "Next",
                    style: pressed
                        ? TextStyle(color: Color.fromRGBO(245, 240, 246, 1))
                        : TextStyle(color: Myconstant.green),
                  ),
                  onPressed: () {
                    if (_val == 0.5) {
                      setState(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ManualPageR(
                            result1: [],
                          );
                        }));
                      });
                    }
                    print('mm: ${_val}');
                  },
                )
              ],
            ),
          ],
        ));
  }
}
