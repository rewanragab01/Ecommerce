import 'package:ecommerce/core/widgets/app_text_button.dart';
import 'package:ecommerce/core/widgets/app_text_form_field.dart';
import 'package:ecommerce/core/widgets/socialmedia.dart';
import 'package:ecommerce/features/auth/data/models/repos/authrepo.dart';
import 'package:ecommerce/features/auth/presentation/views_model/cubit/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBody extends StatefulWidget {
  const AuthBody({
    super.key,
    required this.authState,
    required this.emailController,
    required this.passwordController,
    required this.confirmPassController,
  });

  final String authState;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPassController;

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> {
  final _formKey = GlobalKey<FormState>();
  bool isobscure = true;
  bool isobscureconfirm = true;

  @override
  void dispose() {
    super.dispose();
    widget.emailController.dispose();
    widget.passwordController.dispose();
    widget.confirmPassController.dispose();
  }

  void _handleAuth(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final email = widget.emailController.text.trim();
      final password = widget.passwordController.text.trim();
      final cubit = context.read<AuthCubit>();

      if (widget.authState == 'login') {
        cubit.login(email, password);
      } else {
        cubit.signUp(email, password);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final authrepository = AuthRepository(_firebaseAuth);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: BlocProvider(
        create: (context) => AuthCubit(authrepository),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushNamed(
                  context, '/getstarted'); // Navigate to home on success
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.authState == 'login' ? 'Welcome' : 'Create an',
                    style: const TextStyle(
                        fontSize: 43, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.authState == 'login' ? 'Back!' : 'account',
                    style: const TextStyle(
                        fontSize: 43, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 36),
                  Build_AuthenticationScreen(context),
                  const SizedBox(height: 30),
                  state is AuthLoading
                      ? Center(child: CircularProgressIndicator())
                      : AppTextButton(
                          backgroundColor: const Color(0xffF83758),
                          buttonText: widget.authState == 'login'
                              ? 'Login'
                              : 'Create Account',
                          buttonHeight: 50,
                          buttonWidth: MediaQuery.of(context).size.width * 1,
                          textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                          onPressed: () => _handleAuth(context),
                        ),
                  const SizedBox(height: 25),
                  SocialMediaAuth(context),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Form Build_AuthenticationScreen(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextFormField(
            prefixIcon: const Icon(
              Icons.person,
              size: 24,
            ),
            hintText: 'Username or Email',
            controller: widget.emailController,
            validator: (value) {
              if (value!.isEmpty || !value.contains('@')) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 25),
          AppTextFormField(
            validator: (value) {
              if (value!.isEmpty || value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
            isObscureText: isobscure,
            prefixIcon: const Icon(
              Icons.lock,
              size: 24,
            ),
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  isobscure = !isobscure;
                });
              },
              child: isobscure
                  ? const Icon(
                      Icons.visibility_sharp,
                      size: 24,
                    )
                  : const Icon(
                      Icons.visibility_off_sharp,
                      size: 24,
                    ),
            ),
            hintText: 'Password',
            controller: widget.passwordController,
          ),
          widget.authState == 'login'
              ? const SizedBox(height: 9)
              : const SizedBox(height: 20),
          Row(
            mainAxisAlignment: widget.authState == 'login'
                ? MainAxisAlignment.end
                : MainAxisAlignment.center,
            children: [
              widget.authState == 'login'
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/forgetpasswordscreen');
                      },
                      child: const Text(
                        'Forget Password?',
                        style: TextStyle(color: Color(0xffF83758)),
                      ),
                    )
                  : const Expanded(
                      child: Text.rich(TextSpan(
                          text: 'By clicking the',
                          style: TextStyle(color: Color(0xff676767)),
                          children: [
                          TextSpan(
                              text: ' Register ',
                              style: TextStyle(color: Color(0xffFF4B26))),
                          TextSpan(
                              text: 'button, you agree to the public offer',
                              style: TextStyle(color: Color(0xff676767)))
                        ]))),
            ],
          ),
          widget.authState == 'login'
              ? const SizedBox()
              : const SizedBox(height: 15),
          widget.authState == 'login'
              ? SizedBox()
              : AppTextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    if (value != widget.passwordController.text) {
                      return 'Password doesn\'t match';
                    }
                    return null;
                  },
                  isObscureText: isobscureconfirm,
                  prefixIcon: const Icon(
                    Icons.lock,
                    size: 24,
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isobscureconfirm = !isobscureconfirm;
                      });
                    },
                    child: isobscureconfirm
                        ? const Icon(
                            Icons.visibility_sharp,
                            size: 24,
                          )
                        : const Icon(
                            Icons.visibility_off_sharp,
                            size: 24,
                          ),
                  ),
                  hintText: 'Confirm Password',
                  controller: widget.confirmPassController,
                ),
        ],
      ),
    );
  }

  Center SocialMediaAuth(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            '- OR Continue with -',
            style: TextStyle(color: Color(0xff575757)),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialMedia(
                imageUrl: 'assets/images/google .png',
              ),
              SizedBox(width: 10),
              SocialMedia(imageUrl: 'assets/images/apple.png'),
              SizedBox(width: 10),
              SocialMedia(imageUrl: 'assets/images/facebook.png')
            ],
          ),
          const SizedBox(height: 30),
          SwitchProcess(context),
        ],
      ),
    );
  }

  Row SwitchProcess(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            widget.authState == 'login'
                ? 'Create An Account  '
                : 'I Already Have an Account ',
            style: const TextStyle(color: Color(0xff575757), fontSize: 16)),
        GestureDetector(
          onTap: () {
            widget.authState == 'login'
                ? Navigator.pushNamed(context, '/signup')
                : Navigator.pushNamed(context, '/login');
          },
          child: Text(widget.authState == 'login' ? 'Sign Up' : 'Login',
              style: const TextStyle(
                  decorationThickness: 1.5,
                  decorationColor: Color(0xffF83758),
                  decoration: TextDecoration.underline,
                  color: Color(0xffF83758),
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
