import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_project/Myconstant.dart';

class RightLeft extends StatelessWidget {
  //const RightLeft({Key? key}) : super(key: key);
  String side;
  Color color;
  int averageR;
  int averageL;

  RightLeft(this.side, this.averageR, this.averageL, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 36, right: 1),
        child: Container(
          height: 30,
          width: 140,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.2, left: 3, right: 1),
                child: Container(
                  width: 25,
                  height: 26,
                  decoration: BoxDecoration(
                      color: Myconstant.gray, shape: BoxShape.circle),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, left: 8, right: 1),
                    child: Text(
                      side,
                      style: TextStyle(
                          color: Myconstant.pink, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.3, left: 5, right: 1),
                child: Container(
                  height: 20,
                  width: 45,
                  decoration: BoxDecoration(
                    color: color,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 0.5, left: 20, right: 1),
                    child: Text(
                      '${NumberFormat("###").format(averageR)}',
                      style: TextStyle(
                          color: Myconstant.gray,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.3, left: 5, right: 1),
                child: Container(
                  height: 20,
                  width: 42,
                  decoration: BoxDecoration(
                    color: color,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 1.8, left: 2, right: 1),
                    child: Text(
                      "dB HL",
                      style: TextStyle(
                          color: Myconstant.gray,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }
}
