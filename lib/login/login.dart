import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:stockify/services/auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            const FlutterLogo(size: 150),
            const Spacer(
              flex: 2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FutureBuilder<Object>(
                  future: SignInWithApple.isAvailable(),
                  builder: (context, snapshot) {
                    if (snapshot.data == true) {
                      return LoginButton(
                        icon: FontAwesomeIcons.apple,
                        text: 'Sign in with Apple',
                        loginMethod: AuthService().signInWithApple,
                        color: Colors.black,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                LoginButton(
                  icon: FontAwesomeIcons.ghost,
                  text: 'Continue as Guest',
                  loginMethod: AuthService().anonLogin,
                  color: Colors.deepPurple,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {super.key,
      required this.color,
      required this.icon,
      required this.text,
      required this.loginMethod});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        style: TextButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.all(18),
        ),
        onPressed: () => loginMethod(),
        label: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
