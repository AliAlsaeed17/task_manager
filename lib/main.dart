import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/bloc/bloc_observer.dart';
import 'package:task_manager/injection_container.dart';
import 'package:task_manager/core/themes/app_themes.dart';
import 'package:task_manager/core/utils/routes_manger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Bloc.observer = MyBlocObserver();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppRoutes.navKey,
      title: "Maids CC Task",
      theme: getApplicationTheme(context),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashRoute,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
