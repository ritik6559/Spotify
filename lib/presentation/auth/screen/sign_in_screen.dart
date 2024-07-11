import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tune_box/common/helpers/is_dark_mode.dart';
import 'package:tune_box/common/widgets/app_bar.dart';
import 'package:tune_box/common/widgets/button.dart';
import 'package:tune_box/common/widgets/textfield.dart';
import 'package:tune_box/data/models/auth/signin_user_req.dart';
import 'package:tune_box/domain/usecases/auth/signin_usecase.dart';
import 'package:tune_box/presentation/auth/screen/sign_up_screen.dart';
import 'package:tune_box/presentation/home/screens/home_screen.dart';
import 'package:tune_box/service_locator.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signupText(context),
      appBar: BasicAppbar(
        title: SvgPicture.asset(
          'assets/vectors/spotify_logo.svg',
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            const SizedBox(
              height: 50,
            ),
            BasicTextField(
              hint: "email",
              controller: emailController,
              obscureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
            BasicTextField(
              hint: "password",
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            BasicAppButton(
              onPressed: () async {
                var res = await sl<SigninUsecase>().call(
                  params: SigninUserReq(
                    email: emailController.text,
                    password: passwordController.text,
                  ),
                );

                res.fold(
                  (l) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l,
                        style: TextStyle(
                          color: context.isDarkMode ? Colors.black : Colors.white
                        ),),
                      ),
                    );
                  },
                  (r) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false,
                    );
                  },
                );
              },
              title: 'Sign In',
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Sign In',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }

  Widget _signupText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Don\'t have an account? ',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const SignUpScreen(),
                ),
              );
            },
            child: const Text(
              'Register Now',
            ),
          )
        ],
      ),
    );
  }
}
