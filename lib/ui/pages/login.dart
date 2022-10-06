import 'package:employee/logic/controllers/login.dart';
import 'package:employee/logic/models/login.dart';
import 'package:employee/utils/colors.dart';
import 'package:employee/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:scan/scan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final ScanController controller = ScanController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.done) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.profile, (route) => false);
          }
          if (state.error.isNotEmpty) {
            controller.resume();
          }
        },
        child: Scaffold(
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Builder(builder: (context) {
                return SizedBox.square(
                  dimension: 350,
                  child: ScanView(
                    controller: controller,
                    scanLineColor: AppColors.midnightBlue,
                    onCapture: (data) {
                      context.read<LoginCubit>().login(data);
                    },
                  ),
                );
              }),
              BlocSelector<LoginCubit, LoginState, String>(
                selector: (state) => state.error,
                builder: (context, state) {
                  return Text(
                    state,
                    style: const TextStyle(color: Colors.red, fontSize: 22),
                  );
                },
              ),
              const SizedBox(
                height: 12,
              ),
              BlocSelector<LoginCubit, LoginState, bool>(
                selector: (state) => state.loading,
                builder: (context, state) => Center(
                  child: state
                      ? const CircularProgressIndicator()
                      : const SizedBox(),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
