import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task/login/login_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> checkUserDetails(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final response = await http.post(
          Uri.parse('https://prodbackendv1.ingredo.in/api/auth/login'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        print("token///$token");
        emit(LoginLoaded(token: token));
      } else {
        emit(LoginError(error: 'Login Failed'));
      }
    } catch (e) {
      emit(LoginError(error: e.toString()));
    }
  }
}
