// ignore_for_file: unnecessary_brace_in_string_interps, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/Page/Audiogram.dart';
import 'package:flutter_project/Page/Page4.dart';
import 'Audiogram.dart';

import '../Myconstant.dart';
import 'Page5.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  //final items = List<String>.generate(10, (i) => "การทดสอบครั้งที่ ${i + 1}");
  final FirebaseAuth auth = FirebaseAuth.instance;

  int i = 0;
  String _uid = '';
  late Timestamp today;
  List<int> history = [];
  List<int> history2 = [];
  late DateTime date;
  List<DateTime> time = [];
  //String? meen;

  void initState() {
    getdata();
    super.initState();
  }

  void getdata() async {
    // ignore: unused_local_variable

    User? user = auth.currentUser;
    _uid = user!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .collection('audiogram_history')
        .get()
        .then(
      (value) {
        setState(
          () {
            if (value.docs.length > 0) {
              value.docs.forEach(
                (element) {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(_uid)
                      .collection('audiogram_history')
                      .doc(element.id)
                      .get();
                  today = element.get('created_date');
                  print('object ${today}');
                  DateTime date = today.toDate();
                  time.add(date);
                },
              );
            }
            print('today is ${time}');
          },
        );
      },
    );
  }

  Future getdata2(DateTime pickedDate) async {
    User? user = auth.currentUser;
    _uid = user!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .collection('audiogram_history')
        .where("created_date", isEqualTo: pickedDate)
        .get()
        .then((userDoc2) {
      setState(() {
        if (userDoc2.docs.length > 0) {
          userDoc2.docs.forEach((element) {
            history = List.from(element.get('Left'));
            history2 = List.from(element.get('Right'));
            print('my Left ${history}');
            print('my Right ${history2}');
          });
        }
      });
    });
  }

  Future getdata3() async {
    User? user = auth.currentUser;
    _uid = user!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .collection('audiogram_history')
        .get()
        .then((value) {
      if (value.docs.length > 0) {
        value.docs.forEach((element) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(_uid)
              .collection('audiogram_history')
              .doc(element.id)
              .delete();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(56, 95, 113, 1).withOpacity(0.5),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(245, 240, 246, 1).withOpacity(0.5),
        title: new Center(
          child: new Text(
            "History",
            style: TextStyle(
                color: Color.fromRGBO(245, 240, 246, 1), fontSize: 25),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage(
                          title: '',
                        )));
          },
          child: Icon(
            Icons.home_rounded,
            color: Color.fromRGBO(245, 240, 246, 1),
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.delete, color: Color.fromRGBO(245, 240, 246, 1)),
            itemBuilder: (BuildContext bc) => [
              PopupMenuItem(
                child: FlatButton(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      'Clear all',
                      style: TextStyle(
                          fontSize: 18, color: Color.fromRGBO(1, 1, 1, 1)),
                    ),
                    onPressed: () async {
                      //print(today.length);

                      getdata3();
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(_uid)
                          .update({
                        'today': [],
                      });
                      Navigator.of(context).pushReplacementNamed('/PageHis');
                    }),
              ),
            ],
          )
        ],
      ),
      body: ListView.builder(
        itemCount: time.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: TextButton(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'การทดสอบวันที่ ${time[index]}',
                  style: TextStyle(
                      color: Myconstant.gray,
                      fontFamily: 'Prompt',
                      fontSize: 15),
                  //textAlign: TextAlign.start,
                ),
              ),
              onPressed: () async {
                await getdata2(time[index]);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Audiogram(
                              result: history2,
                              result2: history,
                              sumall: history2[1] +
                                  history2[2] +
                                  history2[3] +
                                  history[1] +
                                  history[2] +
                                  history[3],
                            )));
              },
            ),
          );
        },
      ),
    );
  }
}
