import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

//import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/Page/Page3.dart';

//import 'package:fluttertoast/fluttertoast.dart';

//import 'package:provider/provider.dart';

import '../Myconstant.dart';

class forgotpassword extends StatefulWidget {
  const forgotpassword({Key? key}) : super(key: key);

  @override
  _forgotpasswordState createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {
  final formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  String email = " ";

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Forgot Password',
          style: TextStyle(color: Myconstant.primary, fontSize: 25),
        ),
        backgroundColor: Myconstant.light,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Login();
            }));
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Myconstant.primary,
          ),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                buildtext(size),
                buildmail(size),
                buildsend(size),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Myconstant.primary,
    );
  }

  Row buildmail(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.7,
          height: 40,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your email";
              } else {
                email = value;
              }
              return null;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Myconstant.light,
              labelStyle: TextStyle(fontSize: 15, color: Myconstant.dark),
              labelText: "Email :",
              prefixIcon: Icon(Icons.email, color: Myconstant.dark),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.dark),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.dark),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }

  Row buildsend(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          width: size * 0.4,
          height: 30,
          child: ElevatedButton(
            style: Myconstant().myButtonstyle(),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                FirebaseAuth.instance
                    .sendPasswordResetEmail(email: email)
                    .then((value) => print("Check your mails"));

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return Login();
                }));
              }
            },
            child: Text("Send Email", style: Myconstant().a4Style()),
          ),
        ),
      ],
    );
  }

  Row buildtext(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(top: 50),
            width: size * 1,
            child: Image.asset("assets/image/forgot.jpeg")),
      ],
    );
  }
}
