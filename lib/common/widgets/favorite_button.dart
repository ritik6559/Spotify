import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tune_box/common/bloc/favorite_button/favorite_button_cubit.dart';
import 'package:tune_box/common/bloc/favorite_button/favorite_button_state.dart';
import 'package:tune_box/domain/entities/song/song_entity.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity;
  final Function? function;
  const FavoriteButton({
    super.key,
    required this.songEntity,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit, FavoriteButtonState>(
        builder: (context, state) {
          if (state is FavoriteButtonInitial) {
            return IconButton(
              onPressed: () {
                context
                    .read<FavoriteButtonCubit>()
                    .favoriteButtonUpdate(songEntity.songId);
                if (function != null) {
                  function!();
                }
              },
              icon: Icon(
                songEntity.isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_outline_rounded,
                color: songEntity.isFavorite ? Colors.red : null,
                size: 25,
              ),
            );
          }
          if (state is FavoriteButtonUpdate) {
            return IconButton(
              onPressed: () {
                context
                    .read<FavoriteButtonCubit>()
                    .favoriteButtonUpdate(songEntity.songId);
              },
              icon: Icon(
                state.isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_outline_rounded,
                color: state.isFavorite ? Colors.red : null,
                size: 25,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
