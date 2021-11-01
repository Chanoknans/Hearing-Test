import 'dart:typed_data';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/Page/Page8.dart';
import 'package:flutter_project/Page/PageLeft.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'PageManual.dart';
import '../Myconstant.dart';
import 'Page6.dart';
import 'Page5.dart';
import 'PageLeft.dart';
import 'Page4.dart';

var avgRight = 0;
var avgLeft = 0;
int sum = 0;
int i = 0;

class Audiogram extends StatefulWidget {
  //Audiogram({Key? key}) : super(key: key);
  final List<int>? result; //left
  final List<int>? result2; //right
  final int? sumall;
  Audiogram({Key? key, @required this.result, this.result2, this.sumall})
      : super(key: key);

  @override
  _AudiogramState createState() => _AudiogramState();
}

class _AudiogramState extends State<Audiogram> {
  void MyValue() {
    List<int>? new_val = widget.result;
  }

  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  /*void addon() {
    for (var i = 0; i < 6; i++) {
      sum += widget.result![i];
      print(sum);
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Myconstant.primary,
      appBar: AppBar(
        title: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Result',
                  style: TextStyle(color: Myconstant.primary, fontSize: 25),
                  textAlign: TextAlign.center),
            ]),
        backgroundColor: Myconstant.light,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MyHomePage(title: 'Instruction');
            }));
          },
          child: Icon(
            Icons.home_rounded,
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
                return MyProfile(); //myprofile
              }));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Column(
            children: [
              Container(
                height: 360,
                width: 350,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 210, right: 1),
                      child: Column(
                        children: [
                          Container(
                            height: 30,
                            width: 130,
                            decoration: BoxDecoration(
                                color: Myconstant.green,
                                borderRadius: BorderRadius.circular(11)),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2, left: 12, right: 2),
                                  child: Image.asset(
                                    "assets/image/ear2.png",
                                    height: 24,
                                    width: 24,
                                  ),
                                ),
                                Text(
                                  "Audiogram",
                                  style: TextStyle(
                                      color: Myconstant.light,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 12, left: 12, right: 12),
                      child: Container(
                        height: 290,
                        width: 350,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 0.1),
                            borderRadius: BorderRadius.circular(11)),
                        child: SfCartesianChart(
                          /*legend: Legend(isVisible: true),*/
                          tooltipBehavior: _tooltipBehavior,
                          plotAreaBorderWidth: 0,
                          primaryXAxis: CategoryAxis(
                            labelStyle: TextStyle(color: Myconstant.light),
                            title: AxisTitle(
                                text: 'Frequency (Hz)',
                                textStyle: TextStyle(
                                    color: Myconstant.light,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            majorGridLines: MajorGridLines(width: 0),
                            axisLine:
                                AxisLine(width: 3, color: Myconstant.light),
                          ),
                          primaryYAxis: NumericAxis(
                            labelStyle: TextStyle(color: Myconstant.light),
                            isInversed: true,
                            title: AxisTitle(
                                text: 'Hearing Level (dB HL)',
                                textStyle: TextStyle(
                                    color: Myconstant.light,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            majorGridLines: MajorGridLines(
                                width: 0.5,
                                color: Myconstant.light.withOpacity(0.5)),
                            axisLine:
                                AxisLine(width: 3, color: Myconstant.light),
                            minimum: -10,
                            maximum: 100,
                            interval: 10,
                          ),
                          //Data from Hearing Test
                          series: <ChartSeries>[
                            LineSeries<AudiogramData, String>(
                              enableTooltip: true,
                              dataSource: [
                                AudiogramData('250', widget.result?[0]),
                                AudiogramData('500', widget.result?[1]),
                                AudiogramData('1000', widget.result?[2]),
                                AudiogramData('2000', widget.result?[3]),
                                AudiogramData('4000', widget.result?[4]),
                                AudiogramData('8000', widget.result?[5]),
                              ],
                              color: Myconstant.pink,
                              width: 4,
                              xValueMapper: (AudiogramData freq, _) =>
                                  freq.freq,
                              yValueMapper: (AudiogramData freq, _) =>
                                  freq.hear,
                              markerSettings: MarkerSettings(isVisible: true),
                              /*dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                                textStyle: TextStyle(
                                    color: Myconstant.light, fontSize: 12),
                                offset: Offset(16, 0),
                              ),*/
                            ),
                            LineSeries<AudiogramData2, String>(
                              enableTooltip: true,
                              dataSource: [
                                AudiogramData2('250', widget.result2?[0]),
                                AudiogramData2('500', widget.result2?[1]),
                                AudiogramData2('1000', widget.result2?[2]),
                                AudiogramData2('2000', widget.result2?[3]),
                                AudiogramData2('4000', widget.result2?[4]),
                                AudiogramData2('8000', widget.result2?[5]),
                              ],
                              color: Myconstant.neonblue,
                              width: 4,
                              xValueMapper: (AudiogramData2 freq2, _) =>
                                  freq2.freqs,
                              yValueMapper: (AudiogramData2 freq2, _) =>
                                  freq2.hears,
                              markerSettings: MarkerSettings(isVisible: true),
                              /*dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  textStyle: TextStyle(
                                      color: Myconstant.light, fontSize: 12),
                                  offset: Offset(16, 0),
                                )*/
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 30, right: 1),
                child: Text(
                  "Your average hearing loss",
                  style: TextStyle(color: Myconstant.gray, fontSize: 15),
                ),
              ),
              SizedBox(
                height: 1,
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 36, right: 1),
                child: Container(
                  height: 30,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Myconstant.pink,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 0.1, left: 2, right: 1),
                        child: Container(
                          width: 25,
                          height: 26,
                          decoration: BoxDecoration(
                              color: Myconstant.gray, shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 8, right: 1),
                            child: Text(
                              "R",
                              style: TextStyle(
                                  color: Myconstant.pink,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 0.3, left: 5, right: 1),
                        child: Container(
                          height: 20,
                          width: 45,
                          decoration: BoxDecoration(
                            color: Myconstant.pink,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 0.5, left: 20, right: 1),
                            child: Text(
                              '${((widget.result![0] + widget.result![1] + widget.result![2] + widget.result![3] + widget.result![4] + widget.result![5]) / 6).round()}',
                              style: TextStyle(
                                  color: Myconstant.gray,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 0.3, left: 5, right: 1),
                        child: Container(
                          height: 20,
                          width: 42,
                          decoration: BoxDecoration(
                            color: Myconstant.pink,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 1.8, left: 2, right: 1),
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
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 1),
                child: Container(
                  height: 30,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Myconstant.neonblue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 0.2, left: 3, right: 1),
                        child: Container(
                          width: 25,
                          height: 26,
                          decoration: BoxDecoration(
                              color: Myconstant.gray, shape: BoxShape.circle),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, left: 8, right: 1),
                            child: Text(
                              "L",
                              style: TextStyle(
                                  color: Myconstant.neonblue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 0.3, left: 5, right: 1),
                        child: Container(
                          height: 20,
                          width: 45,
                          decoration: BoxDecoration(
                            color: Myconstant.neonblue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 0.5, left: 20, right: 1),
                            child: Text(
                              '${((widget.result2![0] + widget.result2![1] + widget.result2![2] + widget.result2![3] + widget.result2![4] + widget.result2![5]) / 6).round()}',
                              style: TextStyle(
                                  color: Myconstant.gray,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 0.3, left: 5, right: 1),
                        child: Container(
                          height: 20,
                          width: 42,
                          decoration: BoxDecoration(
                            color: Myconstant.neonblue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 1.8, left: 2, right: 1),
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
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 45, right: 1),
                child: Row(
                  children: [
                    Container(
                      height: 136,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Myconstant.gray,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 9, left: 1, right: 1),
                        child: Column(
                          children: [
                            Container(
                              height: 20,
                              width: 275,
                              decoration: BoxDecoration(
                                color: Myconstant.gray,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2.95, left: 5, right: 1),
                                    child: Text(
                                      "Hearing Loss Grade: ",
                                      style: TextStyle(
                                          color: Myconstant.primary,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      color: Myconstant.gray,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        if ((widget.sumall! / 12) < 26)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3.2, left: 1, right: 0),
                                            child: Text(
                                              "Normal",
                                              style: TextStyle(
                                                color: Myconstant.green,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        else if ((widget.sumall! / 12) >= 26 &&
                                            (widget.sumall! / 12) < 41)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3.2, left: 1, right: 0),
                                            child: Text(
                                              "Slight",
                                              style: TextStyle(
                                                  color: Myconstant.yellow,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )
                                        else if ((widget.sumall! / 12) >= 41 &&
                                            (widget.sumall! / 12) < 61)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3.2, left: 1, right: 0),
                                            child: Text(
                                              "Moderate",
                                              style: TextStyle(
                                                  color: Myconstant.orange,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )
                                        else if ((widget.sumall! / 12) >= 61 &&
                                            (widget.sumall! / 12) < 81)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3.2, left: 1, right: 0),
                                            child: Text(
                                              "Severe",
                                              style: TextStyle(
                                                  color: Myconstant.red,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )
                                        else
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 3.2, left: 1, right: 0),
                                            child: Text(
                                              "Profound",
                                              style: TextStyle(
                                                  color: Myconstant.red,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 4, left: 6, right: 1),
                                  child: Container(
                                    height: 100,
                                    width: 260,
                                    decoration: BoxDecoration(
                                      color: Myconstant.gray,
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        if ((widget.sumall! / 12) < 26)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2, left: 5, right: 0),
                                            child: Text(
                                              "คุณมีระดับการได้ยินที่ปกติหรือมีปัญหาการได้ยินที่น้อยมากคุณสามารถได้ยินเสียงกระซิบเบาๆและเสียงพูดปกติได้",
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color:
                                                      Myconstant.lightprimary,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Prompt'),
                                            ),
                                          )
                                        else if ((widget.sumall! / 12) >= 26 &&
                                            (widget.sumall! / 12) < 41)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2, left: 5, right: 0),
                                            child: Text(
                                              "คุณมีระดับการได้ยินที่ระดับหูตึงเล็กน้อยคุณจะไม่ได้ยินเสียงพูดเบาๆแต่สามารถได้ยินเสียงพูดปกติ ควรปรึกษาแพทย์ผู้เชี่ยวชาญเพื่อตรวจการได้ยินอย่างละเอียด ซึ่งอาจจำเป็นจะต้องใช้เครื่องช่วยฟัง",
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color:
                                                      Myconstant.lightprimary,
                                                  fontSize: 12.2,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Prompt'),
                                            ),
                                          )
                                        else if ((widget.sumall! / 12) >= 41 &&
                                            (widget.sumall! / 12) < 61)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2, left: 5, right: 0),
                                            child: Text(
                                              "คุณมีระดับการได้ยินที่ระดับหูตึงปานกลางคุณจะไม่ได้ยินเสียงพูดปกติต้องพูดให้เสียงดังกว่าปกติจึงจะสามารถได้ยิน ควรไปพบแพทย์ผู้เชี่ยวชาญเพื่อตรวจการได้ยินอย่างละเอียดและคำแนะนำสำหรับการใช้เครื่องช่วยฟัง",
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color:
                                                      Myconstant.lightprimary,
                                                  fontSize: 12.2,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Prompt'),
                                            ),
                                          )
                                        else if ((widget.sumall! / 12) >= 61 &&
                                            (widget.sumall! / 12) < 81)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2, left: 5, right: 0),
                                            child: Text(
                                              "คุณมีระดับการได้ยินที่ระดับหูตึงรุนแรงคุณจะได้ยินเสียงตะโกนหรือเสียงที่มาจากเครื่องขยายเสียง จำเป็นต้องใช้เครื่องช่วยฟังกรณีที่ไม่มีเครื่องช่วยฟังควรจะฝึกการอ่านปาก",
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color:
                                                      Myconstant.lightprimary,
                                                  fontSize: 12.2,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Prompt'),
                                            ),
                                          )
                                        else
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 2, left: 5, right: 0),
                                            child: Text(
                                              "คุณมีระดับการได้ยินที่ระดับหูหนวกคุณจะไม่ได้ยินเสียงตะโกนหรือเสียงที่มาจากเครื่องขยายเสียง และสามารถเข้าใจความหมาย เครื่องช่วยฟังอาจช่วยได้ในเรื่องการทำความเข้าใจคำศัพท์การอ่านปากและการเขียนเป็นสิ่งจำเป็น",
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color:
                                                      Myconstant.lightprimary,
                                                  fontSize: 12.2,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Prompt'),
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class AudiogramData {
  AudiogramData(this.freq, this.hear);
  final String freq;
  final int? hear;
}

class AudiogramData2 {
  AudiogramData2(this.freqs, this.hears);
  final String freqs;
  final int? hears;
}
