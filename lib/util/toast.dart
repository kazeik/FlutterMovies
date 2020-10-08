import 'package:android/app/app_color.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toast {
  static show(String msg) {
    Fluttertoast.showToast(msg: msg, backgroundColor: AppColor.darkGrey, textColor: AppColor.white);
  }
}