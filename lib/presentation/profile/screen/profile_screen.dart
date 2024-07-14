import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tune_box/common/helpers/is_dark_mode.dart';
import 'package:tune_box/common/widgets/app_bar.dart';
import 'package:tune_box/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:tune_box/presentation/profile/bloc/profile_info_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        backgroundColor: const Color(0xFF2C2B2B),
        action: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert_rounded),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          _profileInfo(context),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            color: context.isDarkMode ? const Color(0xFF2C2B2B) : Colors.white,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60),
            ),
          ),
          child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
            builder: (context, state) {
              if (state is ProfileInfoLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ProfileInfoLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(state.userEntity.imageURL!),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        state.userEntity.email.toString(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        state.userEntity.fullName.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return const Center(
                child: Text("An error occureed"),
              );
            },
          ),
        ),
      ),
    );
  }
}
