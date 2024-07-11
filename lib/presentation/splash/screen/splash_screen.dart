import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tune_box/presentation/auth/screen/signup_or_signin_screen.dart';
import 'package:tune_box/presentation/get_started/screen/get_started_screen.dart';
import 'package:tune_box/presentation/home/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset('assets/vectors/spotify_logo.svg'),
      ),
    );
  }

  Future<void> redirect() async {
    final ref = await SharedPreferences.getInstance();
    bool isStartedDone = ref.getBool('isStartedDone') ?? false;
    await Future.delayed(
      const Duration(seconds: 2),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            isStartedDone ? const AuthWrapper() : const GetStartedScreen(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        }
        return const SignupOrSigninScreen();
      },
    );
  }
}
