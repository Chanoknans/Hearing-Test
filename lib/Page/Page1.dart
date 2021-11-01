import 'package:flutter/material.dart';

import '../Myconstant.dart';
import 'Page2.dart';
import 'Page3.dart';

class Homescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 100, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/image/logo.png"),
              SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Myconstant.light),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Login();
                    }));
                  },
                  child: Text(
                    "Log in",
                    style: Myconstant().a1Style()
                  ),
                ),
              ),SizedBox(height: 10,),
              SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Myconstant.light),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SignUp();
                    }));
                  },
                  child: Text(
                    "Sign Up",
                    style: Myconstant().a1Style()
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Myconstant.primary,
    );
  }
}
