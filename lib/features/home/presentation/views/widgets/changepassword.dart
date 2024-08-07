import 'package:ecommerce/core/widgets/app_text_button.dart';
import 'package:ecommerce/core/widgets/app_text_form_field.dart';
import 'package:ecommerce/core/widgets/showdialog.dart';
import 'package:ecommerce/features/auth/data/models/repos/authrepo.dart';
import 'package:ecommerce/features/auth/presentation/views_model/cubit/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController oldpasscontroller = TextEditingController();
  final TextEditingController newpasscontroller = TextEditingController();

  bool isoldobscure = true;
  bool isnewobscure = true;
  GlobalKey<FormState> _formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final authrepository = AuthRepository(_firebaseAuth);
    return BlocProvider(
      create: (context) => AuthCubit(authrepository),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            foregroundColor: Colors.white,
            backgroundColor: Color(0xffFD6E87),
            title: Text(
              'Change Password',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthPasswordChangeSuccess) {
                // showPasswordChangeDialog(context);
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ShowDialog(
                        title: 'Password Changed',
                        content:
                            'Your password has been successfully changed. You can now use your new password to log in.',
                        onPressed: () => Navigator.of(context).pop(),
                      );
                    });
              } else if (state is AuthFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppTextFormField(
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            if (value != oldpasscontroller.text) {
                              return 'Password doesn\'t match';
                            }
                            return null;
                          },
                          isObscureText: isoldobscure,
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isoldobscure = !isoldobscure;
                              });
                            },
                            child: isoldobscure
                                ? const Icon(
                                    Icons.visibility_sharp,
                                    size: 24,
                                  )
                                : const Icon(
                                    Icons.visibility_off_sharp,
                                    size: 24,
                                  ),
                          ),
                          hintText: 'Old Password',
                          controller: oldpasscontroller),
                      SizedBox(
                        height: 25,
                      ),
                      AppTextFormField(
                          validator: (value) {
                            if (value!.isEmpty || value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            if (value != newpasscontroller.text) {
                              return 'Password doesn\'t match';
                            }
                            return null;
                          },
                          isObscureText: isnewobscure,
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isnewobscure = !isnewobscure;
                              });
                            },
                            child: isnewobscure
                                ? const Icon(
                                    Icons.visibility_sharp,
                                    size: 24,
                                  )
                                : const Icon(
                                    Icons.visibility_off_sharp,
                                    size: 24,
                                  ),
                          ),
                          hintText: 'New Password',
                          controller: newpasscontroller),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          state is AuthLoading
                              ? Center(child: CircularProgressIndicator())
                              : AppTextButton(
                                  backgroundColor: Color(0xffFD6E87),
                                  buttonHeight: 50,
                                  buttonWidth: double.infinity,
                                  buttonText: 'Change Password',
                                  textStyle: TextStyle(color: Colors.white),
                                  onPressed: () {
                                    if (_formkey.currentState!.validate()) {
                                      BlocProvider.of<AuthCubit>(context)
                                          .changePassword(
                                              oldpasscontroller.text,
                                              newpasscontroller.text);
                                    }
                                  }),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
