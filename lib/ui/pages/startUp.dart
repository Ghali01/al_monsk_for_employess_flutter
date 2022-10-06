import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:employee/logic/controllers/startUp.dart';
import 'package:employee/utils/routes.dart';
import 'package:employee/utils/server.dart';

class StartUpPage extends StatelessWidget {
  const StartUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StartUpCubit(),
      child: Scaffold(
          body: Center(
        child: BlocConsumer<StartUpCubit, bool?>(
          listenWhen: (previous, current) => current == true,
          listener: (context, state) => Navigator.of(context)
              .pushNamedAndRemoveUntil(Routes.setUp, (route) => false),
          builder: (context, state) {
            if (state == null) {
              return const CircularProgressIndicator();
            }

            if (!state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'فشل العثور على الخادم',
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: () => context.read<StartUpCubit>().scan(),
                      child: const Text('اعادة المحاولة'))
                ],
              );
            }
            return const SizedBox();
          },
        ),
      )),
    );
  }
}
