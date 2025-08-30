import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task/barcode_screen.dart';
import 'package:task/components/text_comp.dart';
import 'package:task/components/textfield_comp.dart';
import 'package:task/login/login_cubit.dart';
import 'package:task/login/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: emailController,
                hintText: "Enter your email",
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                controller: passwordController,
                hintText: "Enter your password",
                prefixIcon: Icon(Icons.lock),
                obscureText: true,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<LoginCubit>().checkUserDetails(
                      email: emailController.text,
                      password: passwordController.text);
                },
                child: CustomText(text: 'Login'))
          ],
        );
      }, listener: (context, state) {
        if (state is LoginLoading) {
          Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoginLoaded) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BarcodeScreen(token: state.token)));
        } else if (state is LoginError) {
          Fluttertoast.showToast(
              msg: state.error,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          print('object///');
        } else {}
      }),
    );
  }
}
