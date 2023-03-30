import 'package:flutter/material.dart';

import 'package:besafe/api_service.dart';
import 'package:besafe/shared/widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController emailOrPhoneController, passwordController;

  @override
  void initState() {
    super.initState();

    emailOrPhoneController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/login-bg.png'),
                fit: BoxFit.contain,
                alignment: Alignment.topCenter)),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            const Spacer(),
            const MainHeader(text: 'Login'),
            Container(
              margin: const EdgeInsets.only(top: 40.0),
              child: Column(
                children: [
                  InputEntry(
                      text: 'Email or phone number',
                      widget: FormattedTextField(
                          text: 'Email or phone',
                          controller: emailOrPhoneController)),
                  InputEntry(
                      text: 'Password',
                      widget: FormattedTextField(
                          text: 'Password',
                          controller: passwordController,
                          obscureText: true)),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 16),
                child: PrimaryButton(
                    text: 'Sign in',
                    onPressed: () {
                      UserApi.loginRequest(emailOrPhoneController.text,
                              passwordController.text)
                          .then((value) =>
                              Navigator.popAndPushNamed(context, '/home'));
                    })),
            const Spacer(),
            const DoNotHaveAnAccountWidget(),
          ],
        ),
      ),
    );
  }
}
