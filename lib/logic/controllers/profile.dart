import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:employee/logic/models/profile.dart';
import 'package:employee/logic/providers/employees.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState()) {
    load().then((value) => null);
    FlutterBackgroundService().on('connectChange').listen((event) {
      print(event);
      emit(state.copyWith(online: event!['value']));
    });
  }

  Future<void> load() async {
    try {
      String rawData = await EmployeesAPI.getProfile();
      var data = jsonDecode(rawData);
      emit(state.copyWith(data: data, online: data['online']));
    } catch (e) {}
  }
}
