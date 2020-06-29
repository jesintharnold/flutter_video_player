import 'package:flutter/material.dart';

class Aspect with ChangeNotifier {
  // ignore: non_constant_identifier_names
  int tap_cnt = 0;
  // ignore: non_constant_identifier_names
  List list_tap_cnt = [
    "16/9",
    "1:1",
    "4:3",
    "16/10",
    "21/9",
    "64/27",
    "2.21/1",
    "2.39/1",
    "5/4"
  ];
  // ignore: non_constant_identifier_names
  get tap_count {
    if (tap_cnt == 0) {
      return 16 / 9;
    } else if (tap_cnt == 1) {
      return 4 / 3;
    } else if (tap_cnt == 2) {
      return 1 / 1;
    } else if (tap_cnt == 3) {
      return 16 / 10;
    } else if (tap_cnt == 4) {
      return 21 / 9;
    } else if (tap_cnt == 5) {
      return 64 / 27;
    } else if (tap_cnt == 6) {
      return 2.21 / 1;
    } else if (tap_cnt == 7) {
      return 2.39 / 1;
    } else if (tap_cnt == 8) {
      return 5 / 4;
    } else {
      tap_cnt = 0;
      return 16 / 9;
    }
  }

  // ignore: non_constant_identifier_names
  get tap_name {
    return list_tap_cnt[tap_cnt];
  }

  void addCnt() {

    tap_cnt += 1;

    notifyListeners();
  }
}
