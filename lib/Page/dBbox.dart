import 'package:flutter/material.dart';
import '../Myconstant.dart';
import 'package:intl/intl.dart';

class dBBox extends StatelessWidget {
  //const dBBox({Key? key}) : super(key: key);
  int fvalues;
  dBBox(this.fvalues);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      width: 155,
      decoration: BoxDecoration(
        color: Color.fromRGBO(196, 196, 196, 1),
      ),
      child: Row(
        children: [
          Padding(padding: const EdgeInsets.only(top: 12, left: 45, right: 2)),
          Container(
            height: 20,
            width: 50,
            decoration: BoxDecoration(
              color: Color.fromRGBO(196, 196, 196, 1),
            ),
            child: Text(
              '${NumberFormat("##").format(fvalues)}',
              style: TextStyle(
                  color: Myconstant.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(padding: const EdgeInsets.only(top: 2, left: 5, right: 5)),
          Container(
            height: 17,
            width: 40,
            decoration: BoxDecoration(
              color: Color.fromRGBO(196, 196, 196, 1),
            ),
            child: Text(
              "dB HL",
              style: TextStyle(
                  color: Myconstant.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
