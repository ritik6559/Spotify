import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tune_box/common/helpers/is_dark_mode.dart';
import 'package:tune_box/common/widgets/app_bar.dart';
import 'package:tune_box/core/configs/theme/app_colors.dart';
import 'package:tune_box/presentation/home/widgets/news_songs_tile.dart';
import 'package:tune_box/presentation/home/widgets/play_list_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        hideBack: true,
        title: SvgPicture.asset(
          'assets/vectors/spotify_logo.svg',
          height: 40,
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _homeTopCard(),
              const SizedBox(height: 30),
              _tabs(),
              SizedBox(
                height: 230,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    const NewsSongsTile(),
                    Container(),
                    Container(),
                    Container()
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const PlayListTile(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return SizedBox(
      height: 140,
      width: double.infinity,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(
              'assets/vectors/home_top_card.svg',
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Image.asset(
                'assets/images/home_artist.png',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
      controller: _tabController,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      tabAlignment: TabAlignment.start,
      labelPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      dividerHeight: 0,
      indicatorColor: AppColors.primary,
      indicatorPadding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      isScrollable: true,
      tabs: const [
        Text(
          'News',
        ),
        Text(
          'Videos',
        ),
        Text(
          'Artist',
        ),
        Text(
          'Podcast',
        ),
      ],
    );
  }
}
