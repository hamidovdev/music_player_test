import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player_test/features/home/home_screen.dart';
import 'package:music_player_test/features/locale_musics/presentation/bloc/locale_musics_bloc.dart';
import 'package:music_player_test/features/network_musics/presentation/bloc/bloc/music_player_bloc.dart';

import 'package:music_player_test/features/playing_music/presentation/bloc/playing_music_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final function = await SharedPreferences.getInstance();
  if (function.getString("function") == null) {
    await function.setString("function", "repeatAll");
  }
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => NetWorkMusicsBloc(),
      ),
      BlocProvider(
        create: (context) => LocaleMusicsBloc(),
      ),
      BlocProvider(
        create: (context) => PlayingMusicBloc(),
      ),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
