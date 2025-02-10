import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/config/theme/context_theme.dart';

class AppIconButton extends StatelessWidget {
  final IconData? icon;
  final Widget? iconWidget;
  final Function()? onTap;
  final Color? backgroundColor;

  const AppIconButton({
    super.key,
    this.icon,
    this.iconWidget,
    this.onTap, this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      style: ButtonStyle(
        shape: WidgetStateProperty.all<CircleBorder>(
          const CircleBorder(),
        ),
        backgroundColor: WidgetStateProperty.all(backgroundColor??context.secondary),
      ),
      icon:iconWidget?? Icon(
        icon,
        color: context.onSecondary,
        size: 18.r,
      ),
      onPressed: onTap,
    );
  }
}
