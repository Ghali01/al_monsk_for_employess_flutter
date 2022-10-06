import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:employee/utils/colors.dart';
import 'package:employee/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetUpPage extends StatelessWidget {
  SetUpPage({Key? key}) : super(key: key) {
    DisableBatteryOptimization.isAllBatteryOptimizationDisabled
        .then((value) async {
      if (value == false) {
        await DisableBatteryOptimization.showDisableAllOptimizationsSettings(
          'ايقاف تحسين البطارية',
          "يجب ايقاف تحسين البطارية",
          'ايقاف تحسين البطارية',
          "يجب ايقاف تحسين البطارية",
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.data!.containsKey('token')) {
                Future.delayed(
                    Duration.zero,
                    () => Navigator.of(context)
                        .pushReplacementNamed(Routes.profile));
                return Container();
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'تسجيل الدخول',
                        style:
                            TextStyle(color: AppColors.blueGray, fontSize: 32),
                      ),
                      const Text(
                          'يمكنك تسجيل الدخول من خلال مسح الرمز  الخاص بالموظف من تطبيق المدير',style: TextStyle(fontSize: 16),),
                      ElevatedButton(
                          onPressed: () => Navigator.of(context)
                              .pushReplacementNamed(Routes.login),
                          child: const Text('تسجيل دخول'))
                    ],
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
