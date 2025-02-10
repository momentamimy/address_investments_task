import 'package:address_investments_task/core/config/theme/context_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/routes/app_screens.dart';
import '../../../../generated/assets.dart';

class OrderConfirmation extends StatelessWidget {
  const OrderConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(Assets.imagesConfirmBackgroundImage),
          ),
          Column(
            children: [
              Spacer(),
              Image.asset(Assets.imagesConfirmMobileImage),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 15.r),
                child: Column(
                  children: [
                    30.verticalSpace,
                    Text(
                      "Order Confirmed",
                      style: context.titleLarge?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    10.verticalSpace,
                    Text(
                        "Your order has been confirmed, we will send you confirmation email shortly.",
                        textAlign: TextAlign.center,
                        style:
                        context.bodyMedium?.copyWith(color: context.hintColor)),
                  ],
                ),
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(double.infinity, 50.h)),
                onPressed: () async {
                  context.pushNamed(AppScreens.home.name);
                },
                child: Text("Continue Shopping"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
