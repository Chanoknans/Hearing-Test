import 'package:flutter/material.dart';
import 'package:flutter_project/Myconstant.dart';

import 'Page3.dart';
import 'Page5.dart';
import 'Page6.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Myconstant.primary,
      appBar: AppBar(
        backgroundColor: Myconstant.light,
        title: new Center(
          child: new Text("Instruction",
              style: TextStyle(color: Myconstant.primary, fontSize: 25),
              textAlign: TextAlign.center),
        ),
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle_outlined,
              size: 30,
            ),
            color: Myconstant.primary,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyProfile();
              }));
            },
          ),
        ],
      ),
      body: Container(
        height: 600,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Myconstant.primary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Myconstant.light,
                  borderRadius: BorderRadius.circular(20)),
              height: 265,
              width: 360,
              child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 1, right: 0),
                  child: Column(
                    children: [
                      Text(
                        "Follow the instruction before testing!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Myconstant.primary,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                          "1. ควรอยู่ในสภาพแวดล้อมที่เงียบและไม่มีสิ่งรบกวน\n"
                          "2. ควรใส่หูฟังทั้ง 2 ข้างในการตรวจการได้ยิน\n"
                          "3. ปรับเสียงให้เหมาะสมตามคำแนะนำในหน้าถัดไป\n"
                          "4. การทดสอบนี้จะใช้เวลาประมาณ 3-5 นาที\n"
                          "5. การทดสอบจะมีประสิทธิภาพมากที่สุดเมื่อทำตาม\nคำแนะนำ",
                          style: TextStyle(
                              color: Myconstant.lightprimary,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Prompt')),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 12, left: 1, right: 1),
                        child: Text(">>เมื่อพร้อมรับการทดสอบให้กดปุ่ม Next<<",
                            style: TextStyle(
                                color: Myconstant.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Prompt')),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            FlatButton(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "Next",
                style: TextStyle(color: Myconstant.light),
              ),
              color: Myconstant.green,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Adjust_sound();
                }));
              },
            )
          ],
        ),
      ),
    );
  }
}
