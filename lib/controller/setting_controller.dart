import 'package:flutter/material.dart';

class SettingController {
  static Widget progressBar(progress) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 15),
        for (int i = 0; i < progress; i++)
          indicatorImg('assets/indicator_on.png'),
        for (int i = 0; i < 3 - progress; i++)
          indicatorImg('assets/indicator_off.png'),
      ],
    );
  }

  static Widget indicatorImg(imgName) {
    return Row(
      children: [
        Image.asset(
          imgName,
          width: 40,
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}
