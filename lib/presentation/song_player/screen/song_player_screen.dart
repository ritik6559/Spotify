import 'package:flutter/material.dart';
import 'package:tune_box/common/helpers/is_dark_mode.dart';
import 'package:tune_box/common/widgets/app_bar.dart';
import 'package:tune_box/core/configs/constants/constants.dart';
import 'package:tune_box/core/configs/theme/app_colors.dart';
import 'package:tune_box/domain/entities/song/song_entity.dart';

class SongPlayerScreen extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayerScreen({
    super.key,
    required this.songEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        action: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert,
          ),
        ),
        title: const Text(
          "Now Playing",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _songCover(context),
              const SizedBox(
                height: 20,
              ),
              _songDetail(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    String image = Uri.encodeComponent(songEntity.title);
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(
          fit: BoxFit.cover,
          '${AppUrls.firestorage}$image.jpeg?${AppUrls.mediaAlt}',
        ),
      ),
    );
  }

  Widget _songDetail(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songEntity.title,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: context.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(songEntity.artist)
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.favorite_border_outlined,
            size: 25,
            color: AppColors.darkGrey,
          ),
        )
      ],
    );
  }
}
