import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/Page/Audiogram.dart';
import 'package:flutter_project/Page/Page5.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/src/audio_cache.dart';
import 'package:flutter_project/Page/PageManual.dart';
import 'dart:async';
import 'dart:io';
import 'PageLeft.dart';

import '../Myconstant.dart';
import 'Page6.dart';
import 'FreqBox.dart';
import 'dBbox.dart';

List<int> _count = [0, 0, 0, 0, 0, 0];
List<int> _round = [16, 10, 16, 13, 8, 19];
double _value = 0;
List<double> _vol = [
  3.191317430952741e-05,
  3.580717051064506e-05,
  4.017630610928088e-05,
  4.507855688029785e-05,
  5.0578972712994904e-05,
  5.675054078361582e-05,
  6.367515405083314e-05,
  7.144469792555517e-05,
  8.016226953450208e-05,
  8.994354575643954e-05,
  0.00010091831818407818,
  0.00011323221537965285,
  0.0001270486352774653,
  0.00014255091337519562,
  0.00015994475548457,
  0.00017946096732250283,
  0.0002013585171627293,
  0.0002259279721874613,
  0.00025349535413735194,
  0.0002844264654219215,
  0.0003191317430952747,
  0.00035807170510645056,
  0.0004017630610928088,
  0.000450785568802978,
  0.0005057897271299491,
  0.0005675054078361582,
  0.0006367515405083308,
  0.0007144469792555517,
  0.0008016226953450208,
  0.0008994354575643945,
  0.0010091831818407797,
  0.0011323221537965296,
  0.0012704863527746532,
  0.0014255091337519548,
  0.0015994475548457001,
  0.0017946096732250265,
  0.0020135851716272953,
  0.002259279721874613,
  0.002534953541373522,
  0.002844264654219206,
  0.0031913174309527443,
  0.0035807170510645096,
  0.004017630610928088,
  0.004507855688029785,
  0.005057897271299491,
  0.0056750540783615765,
  0.006367515405083307,
  0.007144469792555517,
  0.008016226953450207,
  0.008994354575643945,
  0.010091831818407808,
  0.011323221537965297,
  0.012704863527746517,
  0.014255091337519546,
  0.015994475548456975,
  0.017946096732250266,
  0.02013585171627295,
  0.022592797218746116,
  0.025349535413735205,
  0.02844264654219206,
  0.03191317430952743,
  0.035807170510645095,
  0.040176306109280836,
  0.04507855688029782,
  0.050578972712994934,
  0.05675054078361571,
  0.06367515405083307,
  0.07144469792555513,
  0.08016226953450203,
  0.08994354575643936,
  0.10091831818407802,
  0.11323221537965293,
  0.1270486352774652,
  0.1425509133751954,
  0.1599447554845698,
  0.17946096732250252,
  0.20135851716272946,
  0.22592797218746105,
  0.25349535413735214,
  0.28442646542192057,
  0.31913174309527415,
  0.35807170510645087,
  0.40176306109280846,
  0.4507855688029782,
  0.505789727129949,
  0.5675054078361572,
  0.6367515405083305,
  0.7144469792555511,
  0.8016226953450201,
  0.8994354575643932,
  1.0091831818407797,
  1.1323221537965293,
  1.2704863527746522,
  1.4255091337519534,
  1.599447554845698,
  1.7946096732250252,
  2.013585171627294,
  2.25927972187461,
  2.53495354137352,
  2.844264654219205,
  3.1913174309527417,
  3.5807170510645077,
  4.017630610928084,
  4.50785568802978,
  5.057897271299491,
  5.675054078361573,
  6.367515405083301,
  7.144469792555508,
  8.016226953450197,
  8.994354575643936,
  10.091831818407798
];
int i = 0;
int j = _round[0];
List<String> freqs = ['250', '500', '1000', '2000', '4000', '8000'];
final assetsAudioplayer = AssetsAudioPlayer();
final fieldText = TextEditingController();

class ManualPageR extends StatefulWidget {
  //ManualPageR({Key? key}) : super(key: key);
  final List<int>? result1;
  ManualPageR({Key? key, @required this.result1}) : super(key: key);
  @override
  _ManualPageState createState() => _ManualPageState();
}

class _ManualPageState extends State<ManualPageR> {
  AudioCache audioCache = new AudioCache();
  AudioPlayer advancedPlayer = new AudioPlayer();
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer.open(
      Playlist(audios: [
        Audio('assets/sound/right1.mp3'),
        Audio('assets/sound/right2.mp3'),
        Audio('assets/sound/right3.mp3'),
        Audio('assets/sound/right4.mp3'),
        Audio('assets/sound/right5.mp3'),
        Audio('assets/sound/right6.mp3'),
        Audio('assets/sound/right1.mp3'),
        Audio('assets/sound/right1.mp3'),
      ]),
      autoStart: false,
      loopMode: LoopMode.single,
    );
    ClearValue();
  }

  void _increase() async {
    setState(() => _count[i] += 5);
    //_value += 0.05;
    j += 5;
    _value = _vol[j];
    //change to the next index
    _playsound(_value);
    //print('my ${_value}');
  }

  void _playsound(double v) {
    setState(() async {
      await audioPlayer.pause();
      await audioPlayer.setVolume(v); //_vol[j]
      print('this value is $v');
      await audioPlayer.play();
      //await audioPlayer.playlistPlayAtIndex(1);
    });
  }

  void ClearValue() async {
    _count = [0, 0, 0, 0, 0, 0];
    _value = 0;
    i = 0;
    j = _round[0];
    await audioPlayer.stop();
  }

  void _decrease() async {
    setState(() => _count[i] -= 5);
    //_value -= 0.05;
    j -= 5;
    _value = _vol[j];

    _playsound(_value);
  }

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
      body: Row(
        children: [
          SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 90, left: 25, right: 30),
            child: Column(
              children: [
                Container(
                  height: 470,
                  width: 182,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(229, 229, 229, 1),
                      borderRadius: BorderRadius.circular(6)),
                  padding: const EdgeInsets.all(8),
                  child: Column(children: [
                    Text(
                      "In Process...",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Myconstant.primary),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    FreqBox(freqs[0] + " Hz"),
                    dBBox(_count[0]),
                    FreqBox(freqs[1] + " Hz"),
                    dBBox(_count[1]),
                    FreqBox(freqs[2] + " Hz"),
                    dBBox(_count[2]),
                    FreqBox(freqs[3] + " Hz"),
                    dBBox(_count[3]),
                    FreqBox(freqs[4] + " Hz"),
                    dBBox(_count[4]),
                    FreqBox(freqs[5] + " Hz"),
                    dBBox(_count[5]),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      padding: const EdgeInsets.all(1.0),
                      child: Text(
                        "Completed",
                        style:
                            TextStyle(color: Color.fromRGBO(229, 229, 229, 1)),
                      ),
                      color: Myconstant.green,
                      onPressed: () {
                        setState(() async {
                          i += 1;
                          if (i > 5) {
                            await audioPlayer.pause();
                          } else {
                            await audioPlayer.next();
                            _value = _vol[_round[i]];
                            j = _round[i] - 5;
                            //_value = -0.0010091831818407819;
                            _count[i] = -5;
                            _increase();
                          }
                        });
                      },
                    )
                  ]),
                )
              ],
            ),
          ),
          Container(
            height: 500,
            width: 140,
            decoration: BoxDecoration(
              color: Myconstant.primary,
            ),
            child: Column(
              children: [
                Container(
                  height: 70,
                  width: 160,
                  decoration: BoxDecoration(
                    color: Myconstant.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "R",
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: Myconstant.pink),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                ButtonTheme(
                    minWidth: 115,
                    height: 35,
                    child: RaisedButton(
                      color: Color.fromRGBO(177, 116, 116, 1),
                      onPressed: () {
                        _increase();
                        //_playsound();
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
                      onPressed: _decrease,
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
                        //_awaitReturnValueFromSecondScreen(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ManualPageL(resultR: _count);
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
          )
        ],
      ),
    );
  }
}
