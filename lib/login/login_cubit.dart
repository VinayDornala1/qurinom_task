import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task/login/login_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:task/repositary/api.dart';

class LoginCubit extends Cubit<LoginState> {
  final ApiService apiService;
  LoginCubit({required this.apiService}) : super(LoginInitial());
  Future<void> checkUserDetails(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      emit(LoginLoading());
      await Future.delayed(const Duration(seconds: 3));
      final login =
          await apiService.checkUserDetails(email: email, password: password);
      emit(LoginLoaded(token: login['token']));
      // final response = await http.post(
      //     Uri.parse('https://prodbackendv1.ingredo.in/api/auth/login'),
      //     body: jsonEncode({'email': email, 'password': password}),
      //     headers: {'Content-Type': 'application/json'});
      // if (response.statusCode == 200) {
      //   final data = jsonDecode(response.body);
      //   final token = data['token'];
      //   print("token///$token");
      //   emit(LoginLoaded(token: token));
      // } else {
      //   emit(LoginError(error: 'Login Failed'));
      // }
    } catch (e) {
      emit(LoginError(error: e.toString()));
    }
  }
}
