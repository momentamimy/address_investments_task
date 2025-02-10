import 'package:address_investments_task/features/cart/presentation/screen/cart_screen.dart';
import 'package:address_investments_task/features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../features/cart/presentation/screen/order_confirmation.dart';
import '../../../features/home/presentation/screen/home_screen.dart';

import '../../../features/product_details/presentation/screen/product_details_screen.dart';
import 'app_screens.dart';

class AppRouter {
  static final AppRouter _instance = AppRouter._internal();

  static AppRouter get instance => _instance;

  AppRouter._internal() {
    // Router initialization happens here.
  }

  factory AppRouter() {
    return _instance;
  }

  /// Navigation Keys:
  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: parentNavigatorKey,
    initialLocation: AppScreens.home.path,
    routes: [
      myRoute(
        screenRoute: AppScreens.home,
        screen: const HomeScreen(),
      ),
      myRoute(
        screenRoute: AppScreens.productDetails,
        pageBuilder: (context, state) {
          final product = state.extra as ProductModel;
          return defaultTransitionAnimation(
              ProductDetailsScreen(product: product), state);
        },
      ),
      myRoute(
        screenRoute: AppScreens.cart,
        screen: const CartScreen(),
      ),
      myRoute(
        screenRoute: AppScreens.orderConfirmation,
        screen: const OrderConfirmation(),
      ),
    ],
  );

  static Page<dynamic> defaultTransitionAnimation(
      Widget child, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeIn).animate(animation),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 10),
    );
  }

  static RouteBase myRoute({
    required AppScreens screenRoute,
    Widget? screen,
    GoRouterPageBuilder? pageBuilder,
    List<RouteBase>? routes,
    GlobalKey<NavigatorState>? parentNavigatorKey,
  }) {
    return GoRoute(
      parentNavigatorKey: parentNavigatorKey,
      routes: routes ?? <RouteBase>[],
      name: screenRoute.name,
      path: screenRoute.path,
      pageBuilder: pageBuilder ??
          (context, state) => defaultTransitionAnimation(screen!, state),
    );
  }
}
