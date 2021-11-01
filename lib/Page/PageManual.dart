import 'package:flutter/material.dart';
import 'package:flutter_project/Page/Audiogram.dart';
import 'package:flutter_project/Page/Page5.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/src/audio_cache.dart';
import 'dart:async';
import 'dart:io';

import '../Myconstant.dart';
import 'Page6.dart';
import 'FreqBox.dart';
import 'dBbox.dart';

List<int> _count = [0, 0, 0, 0, 0, 0];
int _round = 0;
double _value = 0;
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
int i = 0;
int j = 2;
List<String> freqs = ['250', '500', '1000', '2000', '4000', '8000'];
final assetsAudioplayer = AssetsAudioPlayer();
final fieldText = TextEditingController();
//int len_freqs = freqs.length;

/*//bool isAnimated = false;
bool showPlay = true;
bool shopPause = false;
AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();*/
//AudioCache audioCache = new AudioCache(fixedPlayer: advancedPlayer);

class ManualPage extends StatefulWidget {
  ManualPage({Key? key}) : super(key: key);
  @override
  _ManualPageState createState() => _ManualPageState();
}

class _ManualPageState extends State<ManualPage> {
  AudioCache audioCache = new AudioCache();
  AudioPlayer advancedPlayer = new AudioPlayer();
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  /*void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer.open(Audio('assets/sound/Sound1.mp3'),
        autoStart: false, showNotification: true);
  }*/

  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer.open(
      Playlist(audios: [
        Audio('assets/sound/right1.mp3'),
        Audio('assets/sound/soundf (2).mp3'),
        Audio('assets/sound/soundf (3).mp3'),
        Audio('assets/sound/soundf (4).mp3'),
        Audio('assets/sound/soundf (5).mp3'),
        Audio('assets/sound/sound6.mp3'),
      ]),
      autoStart: false,
      loopMode: LoopMode.single,
    );
    //audioPlayer.next();
    //audioPlayer.previous();
    //audioPlayer.playlistPlayAtIndex(1);
  }
  /*final AudioPlaylist = <Audio>[
    Audio('assets/sound/soundf (1).mp3'),
    Audio('assets/sound/soundf (2).mp3'),
    Audio('assets/sound/soundf (3).mp3'),
    Audio('assets/sound/soundf (4).mp3'),
    Audio('assets/sound/soundf (5).mp3'),
    Audio('assets/sound/soundf (6).mp3'),
  ];
  AssetsAudioPlayer get _assetsAudioPlayer => AssetsAudioPlayer.withId('music');
  final List<StreamSubscription> _subscriptions = [];

  @override
  void initState() {
    super.initState();
    //_subscriptions.add(_assetsAudioPlayer.playlistFinished.listen((data) {
    //  print('finished : $data');
    //}));
    //openPlayer();
    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
    }));
    _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
      print('audioSessionId : $sessionId');
    }));
    _subscriptions
        .add(AssetsAudioPlayer.addNotificationOpenAction((notification) {
      return false;
    }));
    openPlayer();
  }

  void openPlayer() async {
    await _assetsAudioPlayer.open(
      Playlist(audios: AudioPlaylist, startIndex: 0),
      showNotification: true,
      autoStart: false,
    );
  }*/

  void _increase() async {
    setState(() => _count[i] += 5);
    //_value += 0.05;
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
      //await audioPlayer.playlistPlayAtIndex(1);
    });
  }
  /*void _playsound(double vol) {
    setState(() async {
      await audioPlayer.pause();
      audioPlayer.setVolume(vol);
      //j++; //_vol[j]
      print('this value is' + ' ${vol}');
      await audioPlayer.play();
      //await audioPlayer.playlistPlayAtIndex(1);
    });
  }*/

  void ClearValue() async {
    _count = [0, 0, 0, 0, 0, 0];
    _value = 0;
    i = 0;
    j = 0;
    await audioPlayer.stop();
  }

  void _decrease() async {
    setState(() => _count[i] -= 5);
    //_value -= 0.05;
    j--;
    _value = _vol[j];

    _playsound(_value);
  }

  /*void initState() {
    super.initState();
    audioPlayer.open(Audio('assets/sound/Sound1.mp3'),
        autoStart: false, showNotification: true);
  }*/
  /*Future<int> _getDuration() async {
    Uri audiofile = await audioCache.load('Sound1.mp3');
    await advancedPlayer.setUrl(
      audiofile.path,
    );
    int duration = await Future.delayed(
        Duration(seconds: 10), () => advancedPlayer.getDuration());
    return duration;
  }

  getLocalFileDuration() {
    return FutureBuilder<int>(
        future: _getDuration(),
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Text('sample.mp3 duration is: ');
        });
  }*/

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
                            _value = _vol[2];
                            j = 2;
                            //_value = -0.0010091831818407819;
                            _count[i] = -5;
                            _increase();
                          }

                          //audioPlayer.previous();
                          //await audioPlayer.playlistPlayAtIndex(1);
                          /*audioPlayer.next(
                              keepLoopMode: true /*keepLoopMode: false*/);
                          audioPlayer.playlistPlayAtIndex(1)*/
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
                SizedBox(
                  height: 70,
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
                          return Audiogram(
                            result: _count,
                          );
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

  /*void AnimateIcon() {
    setState(() {
      isAnimated = !isAnimated;
      if (isAnimated) {
        audioPlayer.setVolume(1);
        audioPlayer.play();
      } else {
        audioPlayer.pause();
      }
      @override
      void dispose() {
        // TODO: implement dispose
        audioPlayer.dispose();
        super.dispose();
      }
    });
  }*/
  /*void AnimateIcon() {
    setState(() {
      audioPlayer.setVolume(1);
      audioPlayer.play();

      @override
      void dispose() {
        // TODO: implement dispose
        audioPlayer.dispose();
        super.dispose();
      }
    });
  }*/
  /* void _awaitReturnValueFromSecondScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Audiogram(),
        ));
    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      _count = result;
    });
  }*/
}
