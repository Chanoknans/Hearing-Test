import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_project/Page/Page4.dart';
import 'package:flutter_project/Page/forgotpassword.dart';
import 'package:flutter_project/Page/information.dart';
import 'package:flutter_project/Page/informationfb.dart';

import 'package:flutter_project/data/Profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../Myconstant.dart';
import 'Page1.dart';
import 'Page2.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool statusEye = true;
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  Profile profile = Profile(
    email: '',
    password: '',
    confirmpassword: '',
    name: '',
    gen: '',
    date: '',
    Imageurl: '',
  );
  /* void initState() {
    getdata();
    super.initState();
  }

  String? _uid;
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
    });
  }*/

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
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
                leading: IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Homescreen();
                      }));
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                backgroundColor: Myconstant.primary,
              ),
              body: SafeArea(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                  behavior: HitTestBehavior.opaque,
                  child: Form(
                    key: formKey,
                    child: ListView(
                      children: [
                        buildimage(size),
                        buildEmail(size),
                        buildPassword(size),
                        buildlogin(size),
                        buildor(),
                        buildfacebook(size),
                        buildaccount(),
                        buildforgot()
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

  Row buildlogin(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          width: size * 0.8,
          height: 50,
          child: ElevatedButton(
            style: Myconstant().myButtonstyle(),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                try {
                  await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: profile.email, password: profile.password)
                      .then((value) {
                    formKey.currentState!.reset();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MyHomePage(title: 'title');
                    }));
                    // ignore: unnecessary_null_comparison
                    //if (profile.date != null) {
                    //  Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return MyHomePage(title: '');
                    //  }));
                    //  } else
                    //  Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return information();
                    //  }));*/
                  });
                } on FirebaseAuthException catch (e) {
                  print(e.message);
                  Fluttertoast.showToast(
                      msg: e.code, gravity: ToastGravity.CENTER);
                }
              }
            },
            child: Text("Log in", style: Myconstant().a1Style()),
          ),
        ),
      ],
    );
  }

  Row buildimage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: size * 1, child: Image.asset("assets/image/login.JPG")),
      ],
    );
  }

  Row buildEmail(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 15),
          width: size * 0.7,
          child: TextFormField(
            validator: MultiValidator([
              RequiredValidator(errorText: 'Please Enter email'),
              EmailValidator(errorText: 'Please enter a valid email address'),
            ]),
            keyboardType: TextInputType.emailAddress,
            onSaved: (String? email) {
              profile.email = email!;
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Myconstant.light,
              labelStyle: TextStyle(fontSize: 15, color: Myconstant.dark),
              labelText: "Email :",
              prefixIcon: Icon(Icons.email, color: Myconstant.dark),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.dark),
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.dark),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 15),
          width: size * 0.7,
          child: TextFormField(
            validator: RequiredValidator(errorText: 'Please enter password'),
            obscureText: statusEye, //พาสเวิสดอกจัน
            onSaved: (String? password) {
              profile.password = password!;
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      statusEye = !statusEye;
                    });
                  },
                  icon: statusEye
                      ? Icon(
                          Icons.remove_red_eye,
                          color: Myconstant.dark,
                        )
                      : Icon(
                          Icons.remove_red_eye_outlined,
                          color: Myconstant.dark,
                        )),
              filled: true,
              fillColor: Myconstant.light,
              labelStyle: TextStyle(fontSize: 15, color: Myconstant.dark),
              labelText: "Password :",
              prefixIcon: Icon(Icons.lock_outline, color: Myconstant.dark),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.dark),
                  borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Myconstant.dark),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
        )
      ],
    );
  }

  Row buildaccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don’t have an account ?',
          style: Myconstant().a2Style(),
        ),
        TextButton(
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SignUp();
                })),
            child: Text(
              'Sign Up',
              style: TextStyle(
                  fontSize: 18, color: Color.fromRGBO(252, 245, 148, 1)),
            ))
      ],
    );
  }

  Row buildfacebook(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            width: size * 0.8,
            height: 50,
            child: ElevatedButton(
              style: Myconstant().myButtonstyle(),
              onPressed: () async {
                final fb = FacebookLogin();

                final res = await fb.logIn(permissions: [
                  FacebookPermission.publicProfile,
                  FacebookPermission.email,
                ]);

                switch (res.status) {
                  case FacebookLoginStatus.success:
                    final FacebookAccessToken? accessToken = res.accessToken;
                    print('Access token: ${accessToken!.token}');
                    final AuthCredential credential =
                        FacebookAuthProvider.credential(accessToken.token);
                    final result = await FirebaseAuth.instance
                        .signInWithCredential(credential);

                    print('${result.user} is now logged in');

                    // Get profile data
                    final profile = await fb.getUserProfile();
                    print('Hello, ${profile!.name}! You ID: ${profile.userId}');

                    // Get user profile image url
                    final imageUrl = await fb.getProfileImageUrl(width: 100);
                    print('Your profile image: $imageUrl');

                    // Get email (since we request email permission)
                    final email = await fb.getUserEmail();
                    // But user can decline permission
                    if (email != null) print('And your email is $email');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MyHomePage(title: 'title');
                    }));

                    break;
                  case FacebookLoginStatus.cancel:
                    // User cancel log in
                    break;
                  case FacebookLoginStatus.error:
                    // Log in failed
                    print('Error while log in: ${res.error}');
                    break;
                }
                // ignore: unnecessary_null_comparison
                /*if (profile.date != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MyHomePage(title: 'title');
                  }));
                }else
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return informationfb();
                }));*/
              },
              child: Row(
                children: [
                  Icon(
                    Icons.facebook_rounded,
                    size: 50,
                    color: Colors.lightBlue[900],
                  ),
                  Text(
                    "Log in with Facebook",
                    style: Myconstant().a1Style(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ))
      ],
    );
  }

  Row buildor() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        'or',
        style: TextStyle(fontSize: 30, color: Color.fromRGBO(245, 240, 246, 1)),
      )
    ]);
  }

  buildforgot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return forgotpassword();
                })),
            child: Text(
              'Forgot Password ?',
              style: TextStyle(
                  fontSize: 18, color: Color.fromRGBO(252, 245, 148, 1)),
            ))
      ],
    );
  }
}
