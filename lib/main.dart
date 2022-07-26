import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviwemap/flutterMap.dart';
import 'package:webviwemap/readcsv.dart';
import 'package:webviwemap/syncfusionMap.dart';
import 'package:webviwemap/webview.dart';

import 'webviewcommu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebViewScreen(),
    );
  }
}
