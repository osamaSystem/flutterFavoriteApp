import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_hud/progress_hud.dart';

final String tableUser = 'user';
final String columnId = '_id';
final String columnName = 'name';
final String columnPhone = 'phone';
final String columnEmail = 'email';
final String columnFavorite = 'favorite';

showProgress() {
  return ProgressHUD(
    backgroundColor: Colors.black12,
    color: Colors.white,
    containerColor: Colors.black38,
    borderRadius: 5.0,
    text: 'Loading...',
  );
}

showToast(String msg) {
  Fluttertoast.showToast(
      msg: '$msg',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey[800],
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0);
}
