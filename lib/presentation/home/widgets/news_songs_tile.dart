import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tune_box/domain/entities/song/song_entity.dart';
import 'package:tune_box/presentation/home/bloc/new_songs_state.dart';
import 'package:tune_box/presentation/home/bloc/news_songs_cubit.dart';

class NewsSongsTile extends StatelessWidget {
  const NewsSongsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewsSongsCubit()..getNewsSongs(),
      child: SizedBox(
        width: 208,
        child: BlocBuilder<NewsSongsCubit, NewSongsState>(
          builder: (context, state) {
            if (state is NewsSongsLoading) {
              return Container(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is NewsSongsLoaded) {
              return _songs(
                state.songs
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _songs(
    List<SongEntity> songs
  ) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: songs.length,
      separatorBuilder: (context, index) {
        return const SizedBox(width: 14);
      },
      itemBuilder: (context, index) {
        return Column(
          children: [

          ],
        );
      },
    );
  }
}
