import 'dart:async';

import 'package:controle_estoque_amostras_app/2-base/modules/list/pages/list_page.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> showDefaultPopUp(
  String title,
  Widget child,
  String textButton,
  FutureOr<void> Function()? onPressedButton,
  BuildContext context, {
  bool barrierDismissible = true,
}) async {
  return showDialog(
    barrierDismissible: barrierDismissible,
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: SingleChildScrollView(
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: TextWidget(title)),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      child: child,
                    ),
                  ),
                  ButtonWidget(text: textButton, onPressed: onPressedButton),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

Future<void> errorPopUp(String message, BuildContext context) async {
  return showDefaultPopUp(
    "Erro",
    TextWidget(message),
    "Ok",
    () => Navigator.pop(context),
    context,
  );
}

Future<void> successPopUp(String message, BuildContext context) async {
  return showDefaultPopUp(
    "Sucesso",
    TextWidget(message),
    "Ok",
    () => Navigator.pop(context),
    context,
  );
}

Future<void> showListPopUp(
  String title,
  Widget child,
  String textButton,
  FutureOr<void> Function()? onPressedButton,
  BuildContext context,
) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: SizedBox(
          height: 80.h,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: TextWidget(title)),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: child,
                      ),
                    ),
                  ),
                  ButtonWidget(text: textButton, onPressed: onPressedButton),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
