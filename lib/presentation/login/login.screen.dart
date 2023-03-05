import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/decoration_utils.dart';

import '../../infrastructure/widgets/buttons/rounded_rectangle_button.dart';
import 'controllers/login.controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Login',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Please enter the details below to continue',
                style: TextStyle(
                    fontSize: 16, color: AppColors.descriptionTextColor),
              ),
              const SizedBox(height: 30),
              Text(
                'Mobile Number',
                style: TextStyle(
                    fontSize: 18, color: AppColors.titleLabelTextColor),
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: CustomDecorationUtils()
                    .textFieldDecoration(hintText: 'Mobile Number'),
              ),
              const SizedBox(height: 30),
              RoundedRectangleButton(
                onPressed: () {},
                text: 'Continue',
              ),
              const SizedBox(height: 10),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(color: AppColors.titleLabelTextColor),
                  children: [
                    TextSpan(text: "Register",style: TextStyle(color: AppColors.labelGreenTextColor))
                  ],
                ),
              )
            ]),
      ),
    );
  }
}