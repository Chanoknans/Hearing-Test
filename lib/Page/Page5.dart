import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_project/Page/Editprofile.dart';
import 'package:flutter_project/Page/Page4.dart';
import 'package:flutter_project/Page/updatepassword.dart';

import 'package:flutter_project/data/Profile.dart';
import '../Myconstant.dart';
import 'Page1.dart';
import 'dart:ui';
import 'history.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Profile profile = Profile(
      email: '',
      password: '',
      confirmpassword: '',
      date: '',
      gen: '',
      name: '',
      Imageurl: '');
  String? _uid;
  String? _userimage;
  List<String>? date;
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
    setState(() {
      profile.name = userDoc.get('name');
      print('name ${profile.name}');
      profile.gen = userDoc.get('gen');
      profile.date = userDoc.get('date');
      _userimage = userDoc.get('image');
      date = profile.date.split("");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Myconstant.primary.withOpacity(0.5),
        appBar: AppBar(
          backgroundColor: Myconstant.light.withOpacity(0.5),
          title: new Center(
            child: new Text(
              "My Profile",
              style: TextStyle(color: Myconstant.light, fontSize: 25),
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(title: 'title')));
            },
            child: Icon(
              Icons.close,
              color: Myconstant.light,
            ),
          ),
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.more_horiz, color: Myconstant.light),
              itemBuilder: (BuildContext bc) => [
                PopupMenuItem(
                  child: RaisedButton(
                    elevation: 0,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    /*style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(255, 255, 255, 1),
                    ),*/
                    child: Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: 20, color: Color.fromRGBO(1, 1, 1, 1)),
                    ),
                    onPressed: () async {
                      await auth.signOut().then((value) async {
                        await FacebookAuth.instance.logOut();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return Homescreen();
                        }));
                      });
                    },
                  ),
                ),
                PopupMenuItem(
                  child: PopupMenuItem(
                    child: RaisedButton(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      elevation: 0,
                      child: Text(
                        'Change Password',
                        style: TextStyle(
                            fontSize: 20, color: Color.fromRGBO(1, 1, 1, 1)),
                      ),
                      padding: const EdgeInsets.only(right: 4.5),
                      onPressed: () {
                        auth.signOut().then((value) {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return updatepassword();
                          }));
                        });
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(color: Myconstant.primary),
            child: Container(
              width: double.infinity,
              height: 500,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(_userimage ??
                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                      radius: 70,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      profile.name,
                      style: TextStyle(
                          fontSize: 20,
                          color: Myconstant.light,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(auth.currentUser!.email!,
                                style: TextStyle(
                                    fontSize: 18, color: Myconstant.light)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${profile.date.split(" ")[0]}",
                              style: TextStyle(
                                  fontSize: 18, color: Myconstant.light),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              profile.gen,
                              style: TextStyle(
                                  fontSize: 18, color: Myconstant.light),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    FlatButton(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "History",
                        style: TextStyle(color: Myconstant.light),
                      ),
                      color: Myconstant.green,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return HistoryPage();
                        }));
                      },
                    ),
                    FlatButton(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(color: Myconstant.light),
                      ),
                      color: Myconstant.green,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Editprofile();
                        }));
                      },
                    )
                  ],
                ),
              ),
            )));
  }
}
