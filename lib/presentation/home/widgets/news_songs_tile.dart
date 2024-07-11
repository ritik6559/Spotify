import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tune_box/core/configs/constants/constants.dart';
import 'package:tune_box/presentation/home/bloc/new_songs_state.dart';
import 'package:tune_box/presentation/home/bloc/news_songs_cubit.dart';

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
                    onTap: () {},
                    child: SizedBox(
                      width: 160,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Image.network(
                                  '${AppUrls.firestorage}$image.jpeg?${AppUrls.mediaAlt}'),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                  width: 14,
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
