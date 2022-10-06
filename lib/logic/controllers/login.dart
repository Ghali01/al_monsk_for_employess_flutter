import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:employee/logic/models/login.dart';
import 'package:employee/logic/providers/employees.dart';
import 'package:employee/utils/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  void login(String token) async {
    emit(state.copyWith(loading: true, error: ''));
    try {
      String rawData = await EmployeesAPI.login(token);
      var data = jsonDecode(rawData);
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setString('token', data['token']);
      sp.setInt('id', data['id']);
      sp.setInt('userID', data['userID']);
      await initializeService();

      emit(state.copyWith(done: true, error: ''));
    } catch (e) {
      print(e);
      emit(state.copyWith(loading: false, error: 'حدث خطأ'));
    }
  }
}
