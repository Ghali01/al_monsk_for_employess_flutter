import 'package:employee/utils/notifications.dart';
import 'package:employee/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/service.dart';
import 'utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  AppNotifications.init();
  if (sp.containsKey('token')) {
    await initializeService();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Routes.generate,
      initialRoute: Routes.startUp,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('ar', 'SA')],
      locale: const Locale('ar', 'SA'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.darkBlue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              // foregroundColor: MaterialStateProperty.all(AppColors.babyBlue),
              backgroundColor: MaterialStateProperty.all(AppColors.blueGray)),
        ),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(AppColors.blueGray),
        )),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: AppColors.darkBlue),
        timePickerTheme: const TimePickerThemeData(
          dialHandColor: AppColors.darkBlue,
          hourMinuteTextColor: AppColors.midnightBlue,

          // dayPeriodColor: AppColors.babyBlue,
          dayPeriodTextColor: AppColors.midnightBlue,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.blueGray,
        ),
        tabBarTheme: const TabBarTheme(
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.midnightBlue),
            ),
          ),
        ),
      ),
    );
  }
}
