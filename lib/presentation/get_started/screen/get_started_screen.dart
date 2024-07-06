import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tune_box/common/widgets/button.dart';
import 'package:tune_box/core/configs/theme/app_colors.dart';
import 'package:tune_box/presentation/choose_mode/screen/choose_mode_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/intro_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.15),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 40
            ),
            child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(
                      'assets/vectors/spotify_logo.svg'
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Enjoy Listening To Music',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 21,),
                  const Text(
                    'Lost in the worlds largest collection of song lyrics, used by millions of people.',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                      fontSize: 13
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20,),
                  BasicAppButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const ChooseModeScreen()
                        )
                     );
                    },
                    title: 'Get Started'
                  )
                ],
              ),
          )
        ],
      ),
    );
  }
}
