import 'package:controle_estoque_amostras_app/2-base/modules/list/pages/list_page.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> showDefaultSnackBar(String message, BuildContext context) async {
  final snackBar = SnackBar(
    content: TextWidget(message),
    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
    duration: const Duration(seconds: 2),
  );
  final snackbarController = ScaffoldMessenger.of(context).showSnackBar(snackBar);
  await snackbarController.closed;
}
