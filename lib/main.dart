import 'package:address_investments_task/core/services/storage/hive_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'core/config/routes/app_router.dart';
import 'core/config/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'injection_container.dart';

void main() async {
  // Insure initializing widgets:
  WidgetsFlutterBinding.ensureInitialized();
  // Initializing Localization:
  await EasyLocalization.ensureInitialized();
  // Initializing Local Storage:
  await HiveUtils.initHive();
  // Initialize app injections:
  await AppDependencies.initAppInjections();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
          AppConst.kMockupWidth, AppConst.kMockupHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, _) =>
          MaterialApp.router(
            // Routing
            routerConfig: AppRouter.router,
            // Other
            theme: AppTheme.lightTheme(context),
            debugShowCheckedModeBanner: false,
          ),
    );
  }
}
