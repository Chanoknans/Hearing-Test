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
  List<String> today = [];
  List<int> history = [];
  List<int> history2 = [];
  //String? meen;

  void initState() {
    getdata();
    super.initState();
  }

  void getdata() async {
    // ignore: unused_local_variable
    User? user = auth.currentUser;
    _uid = user!.uid;
    print('user.email ${user.email}');

    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();

    await Future.delayed(const Duration(microseconds: 1));
    setState(() {
      today = List.from(userDoc.get('today'));
    });
    //meen = today![1];
  }

  Future getdata2(int value) async {
    User? user = auth.currentUser;
    _uid = user!.uid;
    final DocumentSnapshot userDoc2 = await FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .collection('history')
        .doc(today[value])
        .get();
    setState(() {
      history = List.from(userDoc2.get('Left'));
      history2 = List.from(userDoc2.get('Right'));
      print('my Left ${history}');
      print('my Right ${history2}');
    });
  }

  Future getdata3(int value) async {
    for (i; i < value; i++) {
      User? user = auth.currentUser;
      _uid = user!.uid;
      final DocumentReference<Map<String, dynamic>> userDoc3 = FirebaseFirestore
          .instance
          .collection('users')
          .doc(_uid)
          .collection('history')
          .doc(today[i]);

      setState(() {
        userDoc3.delete();
      });
    }
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
                      print(today.length);

                      getdata3(today.length);
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
        itemCount: today.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: TextButton(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'การทดสอบวันที่ ${today[index]}',
                style: TextStyle(
                    color: Myconstant.gray, fontFamily: 'Prompt', fontSize: 15),
                //textAlign: TextAlign.start,
              ),
            ),
            onPressed: () async {
              await getdata2(index);
              //Text('${history[index]}' + '${history2[index]}');
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
          ) /*Text(
              'การทดสอบวันที่ ${today![index]}',
              style: TextStyle(color: Myconstant.gray, fontFamily: 'Prompt'),
            ),*/
              /*onTap: () {
              getdata2(index);
              Text('${history![index]}');
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Audiogram(
                    result: history2!,
                    result2: history!,
                    sumall: history2![0] +
                        history2![1] +
                        history2![2] +
                        history2![3] +
                        history2![4] +
                        history2![5] +
                        history![0] +
                        history![1] +
                        history![2] +
                        history![3] +
                        history![4] +
                        history![5],
                  );
                },
              ));
            },*/
              );
        },
      ),
    );
  }
}
