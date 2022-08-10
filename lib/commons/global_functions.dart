import 'package:borneo_toys/commons/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GlobalFuntion {
  static Future alert(
      {required BuildContext context,
      required String message,
      bool isWarning = true,
      required String titleButton,
      bool isWarningSuccess = false,
      Function()? onTap}) async {
    Widget okButton = GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 14),
        decoration: BoxDecoration(
          border: Border.all(color: blueColor),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              titleButton,
              style: nunitoTextFont.copyWith(fontSize: 16),
            )
          ],
        ),
      ),
    );

    AlertDialog alert;
    alert = AlertDialog(
      title: SizedBox(
          width: 80,
          height: 80,
          child: Lottie.asset('assets/lotties/success.json')),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: nunitoTextFont.copyWith(fontSize: 16),
      ),
      actions: [
        okButton,
      ],
    );
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
