import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const circularPIndicator = Center(
  child: CircularProgressIndicator(),
);
void showToast({required String msg ,}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 3,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}


const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
const _numbers = '1234567890';

Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    String getRandomNumber(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _numbers.codeUnitAt(_rnd.nextInt(_numbers.length))));