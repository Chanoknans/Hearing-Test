import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Myconstant.dart';

class FreqBox extends StatelessWidget {
  //const FreqBox({Key? key}) : super(key: key);
  String octavefreq;
  FreqBox(this.octavefreq);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text('${octavefreq}',
              style: TextStyle(
                  color: Myconstant.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.start),
        ));
  }
}
