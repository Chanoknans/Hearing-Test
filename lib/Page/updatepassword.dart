import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/Page/Page5.dart';
//import 'package:provider/provider.dart';
import '../Myconstant.dart';
import 'Page3.dart';

class updatepassword extends StatefulWidget {
  const updatepassword({Key? key}) : super(key: key);

  @override
  _updatepasswordState createState() => _updatepasswordState();
}

class _updatepasswordState extends State<updatepassword> {
  final _formKey = GlobalKey<FormState>();
  bool statusEye = true;
  bool statusEye2 = true;
  var newPassword = "";

  final newPasswordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  final currentUser = FirebaseAuth.instance.currentUser;
  changePassword() async {
    try {
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text('Your Password has been Changed. Login again !',
              style: Myconstant().a4Style()),
        ),
      );
    } catch (e) {
      return print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Edit Profile',
            style: TextStyle(color: Myconstant.primary, fontSize: 25),
          ),
          backgroundColor: Myconstant.light,
          leading: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyProfile();
                }));
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: SafeArea(
            child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                buildPassword(size),
                buildPassword2(size),
                buildchange(size)
              ],
            ),
          ),
        )),
        backgroundColor: Myconstant.primary,);
  }

  Row buildPassword(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: size * 0.7,
        margin: EdgeInsets.only(top: 25),
        child: TextFormField(
          autofocus: false,
          obscureText: statusEye,
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
            labelText: 'New Password: ',
            hintText: 'Enter New Password',
            errorStyle: Myconstant().a1Style(),
            prefixIcon: Icon(Icons.lock_outline, color: Myconstant.dark),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Myconstant.dark),
                borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Myconstant.dark),
                borderRadius: BorderRadius.circular(20)),
          ),
          controller: newPasswordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter Password';
            }
            return null;
          },
        ),
      )
    ]);
  }

  Row buildchange(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          width: size * 0.8,
          height: 50,
          child: ElevatedButton(
             style: Myconstant().myButtonstyle(),
            onPressed: () {
              // Validate returns true if the form is valid, otherwise false.
              if (_formKey.currentState!.validate()) {
                setState(() {
                  newPassword = newPasswordController.text;
                });
                changePassword();
              }
            },
            child: Text(
              'Change Password',
              style: Myconstant().a1Style(),
            ),
          ))
    ]);
  }

  Row buildPassword2(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          width: size * 0.7,
          child: TextFormField(
            obscureText: statusEye2, //พาสเวิสดอกจัน
            controller: confirmpasswordController,
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter password';
              }
              if (newPasswordController.text !=
                  confirmpasswordController.text) {
                return 'Password Do not match';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      statusEye2 = !statusEye2;
                    });
                  },
                  icon: statusEye2
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
              labelText: "Confirm Password :",
              prefixIcon: Icon(Icons.lock_outline, color: Myconstant.dark),
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
}
