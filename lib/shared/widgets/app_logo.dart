import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/assets.dart';

class AppLogo extends StatelessWidget {
  final double? height;
  const AppLogo({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.iconsAppLogo,
      height: height??100.h,
    );
  }
}
