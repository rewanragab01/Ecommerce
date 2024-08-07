import 'package:flutter/material.dart';

import 'widgets/authbody.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key, required this.authstate});
  final String authstate;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailcontroller = TextEditingController();
    final TextEditingController _passwordcontroller = TextEditingController();
    final TextEditingController _confirmpasscontroller =
        TextEditingController();

    return SafeArea(
      child: Scaffold(
          body: AuthBody(
              authState: authstate,
              emailController: _emailcontroller,
              passwordController: _passwordcontroller,
              confirmPassController: _confirmpasscontroller)),
    );
  }
}
