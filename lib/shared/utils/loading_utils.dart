import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class LoadingUtils {
  static showLoading(String? msg) {
    SmartDialog.showLoading(
      msg: msg ?? "Loading",
      maskColor: Colors.black.withOpacity(.81),
      backType: SmartBackType.block,
    );
  }
}
