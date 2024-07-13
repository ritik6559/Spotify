import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tune_box/common/helpers/is_dark_mode.dart';
import 'package:tune_box/core/configs/constants/constants.dart';
import 'package:tune_box/core/configs/theme/app_colors.dart';
import 'package:tune_box/presentation/home/bloc/new_songs_state.dart';
import 'package:tune_box/presentation/home/bloc/news_songs_cubit.dart';
import 'package:tune_box/presentation/song_player/screen/song_player_screen.dart';

class NewsSongsTile extends StatelessWidget {
  const NewsSongsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongsCubit()..getNewsSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
          builder: (context, state) {
            if (state is NewsSongsLoading) {
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            }

            if (state is NewsSongsLoaded) {
              final songs = state.songs;
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var image = Uri.encodeComponent(songs[index].title);
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SongPlayerScreen(songEntity: songs[index]),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 160,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        '${AppUrls.coverFirestorage}$image.jpeg?${AppUrls.mediaAlt}')),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  transform:
                                      Matrix4.translationValues(10, 10, 0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: context.isDarkMode
                                        ? AppColors.darkGrey
                                        : const Color(0xffE6E6E6),
                                  ),
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    color: context.isDarkMode
                                        ? const Color(0xff959595)
                                        : const Color(0xff555555),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            songs[index].title,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            songs[index].artist,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  width: 20,
                ),
                itemCount: songs.length,
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
