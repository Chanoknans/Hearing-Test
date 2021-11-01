// ignore_for_file: implementation_imports, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_project/Page/Page4.dart';
import 'package:flutter_project/Myconstant.dart';
import 'Page5.dart';
import 'FreqBox.dart';
import 'dBbox.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/src/audio_cache.dart';
import 'dart:async';
import 'dart:io';

List<int> _count = [0];
double _value = 0;
int i = 0;
int j = 0;
List<double> _vol = [
  3.191317430952741e-05,
  5.675054078361582e-05,
  0.00010091831818407818,
  0.00017946096732250283,
  0.0003191317430952747,
  0.0005675054078361582,
  0.0010091831818407797,
  0.0017946096732250265,
  0.0031913174309527443,
  0.0056750540783615765,
  0.010091831818407808,
  0.017946096732250266,
  0.03191317430952743,
  0.05675054078361571,
  0.10091831818407802,
  0.17946096732250252,
  0.31913174309527415,
  0.5675054078361572,
  1.0091831818407797,
  1.7946096732250252,
  3.1913174309527417,
  5.675054078361573
];
final assetsAudioplayer = AssetsAudioPlayer();

class Calibration extends StatefulWidget {
  Calibration({Key? key}) : super(key: key);

  @override
  _CalibrationState createState() => _CalibrationState();
}

class _CalibrationState extends State<Calibration> {
  AudioCache audioCache = new AudioCache();
  AudioPlayer advancedPlayer = new AudioPlayer();
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer.open(Audio('assets/sound/right1.mp3'),
        autoStart: false, showNotification: true);
  }

  void _increase() async {
    setState(() => _count[i] += 5);
    j++;
    _value = _vol[j];
    //change to the next index
    _playsound(_value);
    //print('my ${_value}');
  }

  void _playsound(double v) {
    setState(() async {
      await audioPlayer.pause();
      audioPlayer.setVolume(v); //_vol[j]
      print('this value is $v');
      await audioPlayer.play();
    });
  }

  void ClearValue() async {
    _count = [0];
    _value = 0;
    i = 0;
    j = 0;
    await audioPlayer.stop();
  }

  void _decrease() async {
    setState(() => _count[i] -= 5);
    j--;
    _value = _vol[j];
    _playsound(_value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Myconstant.primary,
      appBar: AppBar(
        backgroundColor: Myconstant.light,
        title: new Center(
          child: new Text("Calibration",
              style: TextStyle(color: Myconstant.primary, fontSize: 25),
              textAlign: TextAlign.center),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MyHomePage(title: "Instruction");
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
                return MyProfile();
              }));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 125),
                child: Container(
                  height: 170,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Myconstant.primary,
                  ),
                  child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 1, right: 1),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 1, left: 1, right: 115),
                            child: Text(
                              "How to use",
                              style: TextStyle(
                                  color: Myconstant.gray,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 10, right: 10),
                            child: Text(
                              "1. กดปุ่มบวก เมื่อไม่ได้ยินเสียง\n"
                              "2. กดปุ่มลบ เมื่อได้ยินเสียงดังเกินไป\n"
                              "3. กดปุ่ม Complete เมื่อได้ยินเสียงพอดี\n"
                              "4. กดปุ่ม Clear เมื่ออยากเริ่มต้นใหม่\n"
                              "5. กดปุ่ม Next เพื่อไปหน้าต่อไป\n",
                              style: TextStyle(
                                  color: Myconstant.gray,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Prompt'),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 30, right: 10),
                child: Row(
                  children: [
                    Container(
                      height: 260,
                      width: 180,
                      decoration: BoxDecoration(
                          color: Myconstant.gray,
                          borderRadius: BorderRadius.circular(6)),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            "In Process...",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Myconstant.primary),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          FreqBox("1000 Hz"),
                          dBBox(_count[0]),
                          SizedBox(
                            height: 50,
                          ),
                          FlatButton(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              "Completed",
                              style: TextStyle(
                                  color: Color.fromRGBO(229, 229, 229, 1)),
                            ),
                            color: Myconstant.green,
                            onPressed: () {
                              setState(() async {
                                await audioPlayer.next();
                                _value = _vol[2];
                                j = 2;
                                //_value = -0.0010091831818407819;
                                _count[i] = -5;
                                _increase();
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                height: 400,
                width: 140,
                decoration: BoxDecoration(
                  color: Myconstant.primary,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    ButtonTheme(
                        minWidth: 115,
                        height: 35,
                        child: RaisedButton(
                          color: Color.fromRGBO(177, 116, 116, 1),
                          onPressed: () {
                            _increase();
                          },
                          child: Text(
                            "+",
                            style: TextStyle(
                                color: Color.fromRGBO(229, 229, 229, 1),
                                fontSize: 20),
                          ),
                        )),
                    SizedBox(
                      height: 45,
                    ),
                    Container(
                      height: 70,
                      width: 160,
                      decoration: BoxDecoration(
                        color: Myconstant.primary,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3),
                            child: Container(
                              height: 60,
                              width: 85,
                              decoration: BoxDecoration(
                                color: Myconstant.primary,
                              ),
                              child: Text(
                                "${_count[i]}",
                                style: TextStyle(
                                    color: Color.fromRGBO(229, 229, 229, 1),
                                    fontSize: 50,
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              height: 60,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Myconstant.primary,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 9, left: 1, right: 3),
                                child: Text(
                                  "dB HL",
                                  style: TextStyle(
                                    color: Color.fromRGBO(229, 229, 229, 1),
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    ButtonTheme(
                        minWidth: 115,
                        height: 35,
                        child: RaisedButton(
                          color: Color.fromRGBO(139, 187, 137, 1),
                          onPressed: () {
                            _decrease();
                          },
                          child: Text(
                            "-",
                            style: TextStyle(
                                color: Color.fromRGBO(229, 229, 229, 1),
                                fontSize: 20),
                          ),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        FlatButton(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Next",
                            style: TextStyle(color: Myconstant.primary),
                          ),
                          color: Color.fromRGBO(229, 229, 229, 1),
                          minWidth: 90,
                          height: 30,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            print(_count);
                            audioPlayer.stop();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Text("bibi");
                              //return ManualPage();
                            }));
                          },
                        ),
                        FlatButton(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Clear",
                            style: TextStyle(color: Myconstant.primary),
                          ),
                          color: Color.fromRGBO(229, 229, 229, 1),
                          minWidth: 90,
                          height: 30,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            setState(() {
                              ClearValue();
                              print("initialize value");
                            });
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
