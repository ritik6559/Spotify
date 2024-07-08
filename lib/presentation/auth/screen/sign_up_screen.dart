import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tune_box/common/widgets/app_bar.dart';
import 'package:tune_box/common/widgets/button.dart';
import 'package:tune_box/common/widgets/textfield.dart';
import 'package:tune_box/presentation/auth/screen/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: SvgPicture.asset(
          'assets/vectors/spotify_logo.svg',
          height: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  _registerText(),
                  const SizedBox(height: 80),
                  BasicTextField(
                    hint: "Name",
                    controller: nameController,
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  BasicTextField(
                    hint: "Enter email",
                    controller: emailController,
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  BasicTextField(
                    hint: "Enter password",
                    controller: passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: BasicAppButton(
                      onPressed: () {},
                      title: "Create Account",
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => SignInScreen(),
                        ),
                      );
                    },
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      "Register",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }
}
