import 'dart:developer';

import 'package:cobapluginmidpay/apiservice.dart';
import 'package:flutter/material.dart';
import 'package:midpay/midpay.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final midtrans = Midpay();
  ApiService _service = new ApiService();
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    midtrans.init(
        'SB-Mid-client-snpmAPlg6tp1bSsm', 'https://nata.id/api-psikologimu/',
        environment: Environment.sanbox);
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Uuid uuid = Uuid();
            await _service.getMidtrans(uuid.v1()).then((response) async {
              log("response : $response");
              await midtrans.makePaymentToken(response['token']);
            });
          },
        ),
      ),
    );
  }
}
