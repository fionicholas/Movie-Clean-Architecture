import 'package:core/presentation/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String message) {
  Fluttertoast.showToast(msg: message);
}

void showLoading(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => const LoadingDialog(),
  );
}

void hideLoading(BuildContext context){
  Navigator.maybePop(context);
}