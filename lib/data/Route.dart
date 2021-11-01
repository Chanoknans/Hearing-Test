import 'package:flutter/cupertino.dart';
import 'package:flutter_project/Page/Page1.dart';
import 'package:flutter_project/Page/Page3.dart';
import 'package:flutter_project/Page/Page4.dart';

final Map<String, WidgetBuilder> routes = {
  '/Page3': (BuildContext context) => Login(),
  '/Page4': (BuildContext context) => MyHomePage(title: ''),
  '/Page1': (BuildContext context) => Homescreen()
};
