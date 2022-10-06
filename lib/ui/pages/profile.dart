import 'package:employee/logic/controllers/profile.dart';
import 'package:employee/logic/models/profile.dart';
import 'package:employee/ui/widgets/bottomBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0).copyWith(top: 32),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'الاسم',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "${state.data!['firstName']} ${state.data!['secondName']}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'البريد الالكتروني',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        state.data!['email'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'وقت الدوام',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "${state.data!['start'].substring(0, 5)}-${state.data!['end'].substring(0, 5)}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'حالة الاتصال',
                        style: TextStyle(fontSize: 16),
                      ),
                      BlocSelector<ProfileCubit, ProfileState, bool>(
                        selector: (state) => state.online!,
                        builder: (context, state) {
                          return Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: state ? Colors.green : Colors.red),
                          );
                        },
                      )
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: const BottomBar(index: 0),
      ),
    );
  }
}
