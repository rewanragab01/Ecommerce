import 'package:ecommerce/core/widgets/showdialog.dart';
import 'package:ecommerce/features/auth/data/models/repos/authrepo.dart';
import 'package:ecommerce/features/auth/presentation/views_model/cubit/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/core/widgets/app_text_button.dart';
import 'package:ecommerce/core/widgets/app_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordBody extends StatelessWidget {
  const ForgetPasswordBody({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey();
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final authrepository = AuthRepository(_firebaseAuth);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 62),
      child: BlocProvider(
        create: (context) => AuthCubit(authrepository),
        child: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Forget',
                  style: TextStyle(fontSize: 43, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Password?',
                  style: TextStyle(fontSize: 43, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 32),
                Form(
                  key: _formKey,
                  child: AppTextFormField(
                    hintText: 'Enter Your Email',
                    controller: _emailController,
                    prefixIcon: Icon(Icons.email, size: 24),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 26),
                Text.rich(
                  TextSpan(
                    text: '*',
                    style: TextStyle(color: Colors.red),
                    children: [
                      TextSpan(
                        text:
                            ' We will send you a message to set or reset your new password',
                        style: TextStyle(color: Color(0xff676767)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                state is AuthLoading
                    ? Center(child: CircularProgressIndicator())
                    : AppTextButton(
                        backgroundColor: Color(0xffF83758),
                        buttonText: 'Submit',
                        buttonHeight: 50,
                        buttonWidth: MediaQuery.of(context).size.width * 1,
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context)
                                .forgotPassword(_emailController.text);
                          }
                        },
                      ),
              ],
            );
          },
          listener: (context, state) {
            if (state is AuthPasswordResetSuccess) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ShowDialog(
                    title: 'Password Reset',
                    content:
                        'A password reset link has been sent to your email. Please check your inbox to reset your password.',
                    onPressed: () => Navigator.of(context).pushNamed('/login'),
                  );
                },
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
        ),
      ),
    );
  }
}
