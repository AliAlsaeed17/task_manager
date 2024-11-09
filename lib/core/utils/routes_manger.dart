import 'package:flutter/material.dart';
import 'package:task_manager/features/splash/presentation/pages/splash_page.dart';
import 'package:task_manager/features/auth/presentation/pages/login_page.dart';
import 'package:task_manager/features/home/presentation/pages/home_page.dart';

class AppRoutes {
  static final navKey = GlobalKey<NavigatorState>();
  static const String splashRoute = '/';
  static const String loginRoute = '/loginRoute';
  static const String homeRoute = '/homeRoute';

  static Route? onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) {
          return Builder(
            builder: (BuildContext context) {
              switch (settings.name) {
                case splashRoute:
                  return const SplashPage();
                case loginRoute:
                  return const LoginPage();
                case homeRoute:
                  return const HomePage();
                default:
                  return const Scaffold(
                    body: Center(
                      child: Text(
                        'Check Named Route',
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                    ),
                  );
              }
            },
          );
        },
        settings: settings);
  }

  static navGo(BuildContext context,
      {required String routeName, Object? arguments}) {
    Navigator.of(context).pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  static navOfAll(BuildContext context,
      {required String routeName, Object? arguments}) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }
}
