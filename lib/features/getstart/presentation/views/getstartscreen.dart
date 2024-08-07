import 'package:ecommerce/core/widgets/app_text_button.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/getstared.png'),
                    fit: BoxFit.cover)),
          ),
          Container(
            alignment: Alignment(0, 0.5),
            child: const Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Text(
                  'You want Authentic, here you go!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                )),
          ),
          Container(
            alignment: Alignment(0, 0.68),
            child: const Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Text(
                  'Find it here, buy it now!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xffF2F2F2),
                      fontSize: 16),
                )),
          ),
          Container(
            alignment: Alignment(0, 0.96),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: AppTextButton(
                  backgroundColor: Color(0xffF83758),
                  buttonText: 'Get Started',
                  buttonHeight: 50,
                  buttonWidth: MediaQuery.of(context).size.width * 0.6,
                  textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
