import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:path/path.dart';
import 'package:flutter/material.dart';

import 'package:flutter_project/Page/Page5.dart';

import 'package:flutter_project/data/Profile.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';

import '../Myconstant.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({Key? key}) : super(key: key);

  @override
  _EditprofileState createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  final formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  String? url;
  Profile profile = Profile(
    email: '',
    password: '',
    confirmpassword: '',
    name: '',
    gen: '',
    date: '',
    Imageurl: '',
  );
  File? _Image;
  final picker = ImagePicker();

  _picimagecamera() async {
    // ignore: deprecated_member_use
    final pickedimage = await picker.getImage(source: ImageSource.camera);
    final pickegeimagefile = File(pickedimage!.path);
    setState(() {
      _Image = pickegeimagefile;
    });

    Navigator.pop(this.context);
  }

  _picimagegallery() async {
    // ignore: deprecated_member_use
    final pickedimage = await picker.getImage(source: ImageSource.gallery);
    final pickegeimagefile = File(pickedimage!.path);
    setState(() {
      //_Image!.add(File(pickedimage.path));
      _Image = pickegeimagefile;
    });
    //ignore: unnecessary_null_comparison
    //if (pickedimage.path == null) reLostdata();

    Navigator.pop(this.context);
  }

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  String? _uid;
  List<String>? today;

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
      print(profile.name.runtimeType);
      profile.gen = userDoc.get('gen');
      profile.date = userDoc.get('date');
      profile.Imageurl = userDoc.get('image');
      profile.email = user.email!;
      today = List.from(userDoc.get('today'));
    });
  }

  @override
  Widget build(BuildContext context) {
    //double size = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Error'),
              ),
              body: Center(
                child: Text('${snapshot.error}'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'Edit Profile',
                  style: TextStyle(color: Myconstant.primary, fontSize: 25),
                ),
                backgroundColor: Myconstant.light,
              ),
              body: SafeArea(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                  behavior: HitTestBehavior.opaque,
                  child: Form(
                    key: formKey,
                    child: ListView(
                      children: [
                        buildimage(),
                        buildname(),
                        buildbirthday(),
                        buildgen(),
                        buildsave(),
                      ],
                    ),
                  ),
                ),
              ),
              backgroundColor: Myconstant.primary,
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  buildimage() {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Stack(children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: CircleAvatar(
              radius: 85,
              backgroundColor: Myconstant.light,
              child: CircleAvatar(
                radius: 80,
                backgroundImage: _Image == null ? null : FileImage(_Image!),
              ),
            ),
          ),
          Positioned(
              top: 120,
              left: 120,
              child: RawMaterialButton(
                elevation: 10,
                fillColor: Myconstant.light,
                child: Icon(Icons.add_a_photo),
                padding: EdgeInsets.all(15),
                shape: CircleBorder(),
                onPressed: () {
                  showDialog(
                      context: this.context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: Text(
                              'Choose option',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Myconstant.primary),
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  InkWell(
                                    onTap: _picimagecamera,
                                    splashColor: Myconstant.primary,
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Icon(
                                              Icons.camera,
                                              color: Myconstant.primary,
                                            )),
                                        Text('Camera',
                                            style: Myconstant().a4Style())
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: _picimagegallery,
                                    splashColor: Myconstant.primary,
                                    child: Row(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Icon(
                                              Icons.image,
                                              color: Myconstant.primary,
                                            )),
                                        Text('Gallery',
                                            style: Myconstant().a4Style())
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      });
                },
              ))
        ]),
      ],
    );
  }

  buildname() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: 300,
          height: 50,
          child: TextFormField(
            initialValue: "${profile.name}",
            validator: RequiredValidator(errorText: 'Please Enter Name'),
            decoration: InputDecoration(
              filled: true,
              fillColor: Myconstant.light,
              labelStyle: TextStyle(fontSize: 20, color: Myconstant.dark),
              labelText: "Name :",
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.dark),
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.dark),
                  borderRadius: BorderRadius.circular(20)),
            ),
            onSaved: (String? name) {
              profile.name = name!;
            },
          ),
        )
      ],
    );
  }

  buildbirthday() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: 300,
            height: 50,
            decoration: BoxDecoration(
              color: Myconstant.light,
              border: Border.all(color: Myconstant.light),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ElevatedButton(
                style: Myconstant().myButtonstyle(),
                onPressed: () => _selectDate(this.context),
                child: Text(
                  "Select date : " +
                      "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}"
                          .toString(),
                  style: Myconstant().a1Style(),
                ))),
      ],
    );
  }

  buildgen() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: 300,
          height: 50,
          child: TextFormField(
            initialValue: "${profile.gen}",
            validator: RequiredValidator(errorText: 'Please Enter Gender'),
            decoration: InputDecoration(
              filled: true,
              fillColor: Myconstant.light,
              labelStyle: TextStyle(fontSize: 20, color: Myconstant.dark),
              labelText: "Gender :",
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.dark),
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.dark),
                  borderRadius: BorderRadius.circular(20)),
            ),
            onSaved: (String? gen) {
              profile.gen = gen!;
            },
          ),
        )
      ],
    );
  }

  buildsave() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          width: 300,
          height: 60,
          child: ElevatedButton(
            style: Myconstant().myButtonstyle(),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();

                final ref = FirebaseStorage.instance
                    .ref()
                    .child('userimage')
                    .child(profile.name + '.jpg');
                await ref.putFile(_Image!);
                url = await ref.getDownloadURL();
                final User? user = auth.currentUser;
                final _uid = user!.uid;
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(_uid)
                    .set({
                  'id': _uid,
                  'name': profile.name,
                  'gen': profile.gen,
                  'date': selectedDate.toString(),
                  'image': url,
                  'today': today,
                });

                formKey.currentState!.reset();
                Navigator.pushReplacement(this.context,
                    MaterialPageRoute(builder: (context) {
                  return MyProfile();
                }));
              }
            },
            child: Text("Save", style: Myconstant().a1Style()),
          ),
        ),
      ],
    );
  }
}
