import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_test/core/app_status/main_status.dart';
import 'package:music_player_test/core/extension/to_entity_extensions.dart';
import 'package:music_player_test/features/locale_musics/domain/entity/locale_musics_entity.dart';
import 'package:music_player_test/features/locale_musics/presentation/bloc/locale_musics_bloc.dart';
import 'package:music_player_test/features/playing_music/presentation/pages/playing_music_screen.dart';

class LocaleMusicsSingleScreen extends StatefulWidget {
  final AudioPlayer player;
  const LocaleMusicsSingleScreen({super.key, required this.player});

  @override
  State<LocaleMusicsSingleScreen> createState() =>
      _LocaleMusicsSingleScreenState();
}

class _LocaleMusicsSingleScreenState extends State<LocaleMusicsSingleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131524),
      body: BlocBuilder<LocaleMusicsBloc, LocaleMusicsState>(
        builder: (context, state) {
          List<LocaleMusicsEntity> localReceivedMusics = state.musics;
          switch (state.status) {
            case Status.none:
              context.read<LocaleMusicsBloc>().add(GetLocalMusics());
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            case Status.loading:
              return const Center(
                child: CupertinoActivityIndicator(
                  color: Colors.white,
                  radius: 14,
                ),
              );
            case Status.success:
              return ListView.separated(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => PlayingMusicScreen(
                              audioPlayer: widget.player,
                              musicindex: index,
                              musics: (localReceivedMusics.map(
                                (data) => data.localeToNetwork,
                              )).toList(),
                              lastDataisLocal: true,
                            ),
                          ),
                        );
                        await widget.player
                            .setUrl(localReceivedMusics[index].source);
                        widget.player.play();
                      },
                      child: Container(
                        height: MediaQuery.sizeOf(context).height / 100 * 7,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: const Color(0xFF313340),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            Image.network(
                              state.musics[index].imgurl,
                              fit: BoxFit.cover,
                              width:
                                  MediaQuery.sizeOf(context).width / 100 * 14,
                              height:
                                  MediaQuery.sizeOf(context).height / 100 * 10,
                            ),
                            const Gap(20),
                            SizedBox(
                              width:
                                  MediaQuery.sizeOf(context).width / 100 * 55,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    state.musics[index].title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(
                                          0xFFFEFEFE,
                                        )),
                                  ),
                                  Text(
                                    state.musics[index].artist,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFFFEFEFE)
                                            .withOpacity(0.6)),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "${state.musics[index].duration ~/ 60 < 10 ? "0${state.musics[index].duration ~/ 60}" : state.musics[index].duration ~/ 60}:${state.musics[index].duration % 60 < 10 ? "0${state.musics[index].duration ~/ 60}" : "${state.musics[index].duration % 60}"}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, __) {
                    return const Gap(20);
                  },
                  itemCount: localReceivedMusics.length);
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
