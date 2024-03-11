import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_test/features/locale_musics/presentation/pages/locale_musics_screen.dart';
import 'package:music_player_test/features/network_musics/presentation/pages/network_musics.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  final musicplayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF131524),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: TabBar(
              controller: tabController,
              indicatorColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              dividerColor: Colors.transparent,
              unselectedLabelColor: Color(0xFFABABAB),
              labelColor: Colors.white,
              tabs: const [
                Tab(
                  child: Text(
                    "Recommendation",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Your musics",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      // color: Color(0xFF19B7F9),
                    ),
                  ),
                ),
              ]),
        ),
        body: Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).padding.bottom + 20),
          child: TabBarView(
            controller: tabController,
            children: [
              NetWorkSingleMusicsScreen(
                player: musicplayer,
              ),
              LocaleMusicsSingleScreen(
                player: musicplayer,
              ),
            ],
          ),
        ));
  }
}
