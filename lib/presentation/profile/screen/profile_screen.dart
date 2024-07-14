import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tune_box/common/helpers/is_dark_mode.dart';
import 'package:tune_box/common/widgets/app_bar.dart';
import 'package:tune_box/common/widgets/favorite_button.dart';
import 'package:tune_box/core/configs/constants/constants.dart';
import 'package:tune_box/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:tune_box/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:tune_box/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:tune_box/presentation/profile/bloc/profile_info_state.dart';
import 'package:tune_box/presentation/song_player/screen/song_player_screen.dart';

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
          _favoriteSongs(),
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
                      Column(
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

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FAVORITE SONGS',
            ),
            
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<FavoriteSongsCubit,FavoriteSongsState>(
              builder: (context,state) {
                if(state is FavoriteSongsLoading) {
                  return const CircularProgressIndicator();
                }
                if(state is FavoriteSongsLoaded) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (BuildContext context) => SongPlayerScreen(songEntity: state.favoriteSongs[index])
                            )
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        '${AppUrls.coverFirestorage}${Uri.encodeComponent(state.favoriteSongs[index].title)}.jpeg?${AppUrls.mediaAlt}'
                                      )
                                    )
                                  ),
                                ),
                      
                                const SizedBox(width: 10, ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.favoriteSongs[index].title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                        ),
                                      ),
                                      const SizedBox(height: 5, ),
                                        Text(
                                          state.favoriteSongs[index].artist,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 11
                                          ),
                                        ),
                                    ],
                                  )
                      
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  state.favoriteSongs[index].duration.toString().replaceAll('.', ':')
                                ),
                                const SizedBox(width: 20, ),
                                  FavoriteButton(
                                    songEntity: state.favoriteSongs[index],
                                    key: UniqueKey(),
                                    function: (){
                                      context.read<FavoriteSongsCubit>().removeSong(index);
                                    },
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 20,),
                    itemCount: state.favoriteSongs.length
                 );
                }
                if(state is FavoriteSongsFailure) {
                  return const Text(
                    'Please try again.'
                  );
                }
                return Container();
              } ,
            )
          ],
        ),
      ),
    );
  }
}
