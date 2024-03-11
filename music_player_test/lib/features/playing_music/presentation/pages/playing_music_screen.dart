import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player_test/core/app_status/main_status.dart';
import 'package:music_player_test/core/app_status/player_functions.dart';
import 'package:music_player_test/features/network_musics/domain/entity/entity.dart';
import 'package:music_player_test/features/playing_music/domain/entity/playing_music_entity.dart';
import 'package:music_player_test/features/playing_music/presentation/bloc/playing_music_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayingMusicScreen extends StatefulWidget {
  final AudioPlayer audioPlayer;
  final int musicindex;
  final List<NetWorkMusicsEntity> musics;
  final bool lastDataisLocal;
  const PlayingMusicScreen(
      {super.key,
      required this.audioPlayer,
      required this.musicindex,
      required this.musics,
      required this.lastDataisLocal});

  @override
  State<PlayingMusicScreen> createState() => _PlayingMusicScreenState();
}

class _PlayingMusicScreenState extends State<PlayingMusicScreen> {
  bool? downloadButtonIsDisabled;
  @override
  void initState() {
    downloadButtonIsDisabled = widget.lastDataisLocal;
    context.read<PlayingMusicBloc>().add(ReplacePage());
    widget.audioPlayer.bufferedPositionStream.listen((event) {
      context.read<PlayingMusicBloc>().add(EditDuration(
          minute: event.inMinutes,
          second: event.inSeconds,
          success: () {
            context
                .read<PlayingMusicBloc>()
                .add(EditIndex(player: widget.audioPlayer, isFinished: true));
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
        backgroundColor: Colors.transparent,
        title: const Text(
          "Music Player",
          style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5),
        ),
      ),
      backgroundColor: const Color(0xFF131524),
      body: BlocBuilder<PlayingMusicBloc, PlayingMusicState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.none:
              context.read<PlayingMusicBloc>().add(GetMusic(
                    music: widget.musics[widget.musicindex],
                    index: widget.musicindex,
                    musics: widget.musics,
                  ));
              return const SizedBox();
            case Status.loading:
              return const Center(
                child: CupertinoActivityIndicator(
                  color: Colors.white,
                  radius: 14,
                ),
              );
            case Status.downloading:
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoActivityIndicator(
                      color: Colors.white,
                      radius: 14,
                    ),
                    Gap(10),
                    Text(
                      "Yuklanmoqda...",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              );
            case Status.success:
              () async {
                final sharedIns = await SharedPreferences.getInstance();
                if ((sharedIns.getBool(widget.musics[widget.musicindex].id)) ==
                    true) {
                  downloadButtonIsDisabled = true;
                }
              };
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 15,
                    left: 12,
                    right: 12,
                    top: MediaQuery.of(context).padding.top + 20),
                child: Column(
                  children: [
                    const Gap(50),
                    Image.network(
                      state.music!.imgurl,
                      fit: BoxFit.cover,
                    ),
                    const Gap(30),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 100 * 75,
                      child: Column(
                        children: [
                          Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            state.music!.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            state.music!.artist,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.sizeOf(context).width -
                                  (MediaQuery.sizeOf(context).width /
                                      state.music!.duration *
                                      state.part)),
                          child: Container(
                            width: double.maxFinite,
                            height: 8,
                            decoration: BoxDecoration(
                                color: const Color(0xFF4B7FD6),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        const Gap(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.durationData,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "${state.music!.totalTrackCount} / ${state.music!.trackNumber}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5),
                            )
                          ],
                        )
                      ],
                    ),
                    const Gap(40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context
                                .read<PlayingMusicBloc>()
                                .add(AddFunctions());
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 7, bottom: 7),
                            decoration: BoxDecoration(
                                color: const Color(0xFF4B7FD6),
                                borderRadius: BorderRadius.circular(10),
                                // border: Border.all(
                                //     color: Colors.green.withOpacity(0.4),
                                //     width: 1),
                                boxShadow: const [
                                  BoxShadow(color: Colors.blue, blurRadius: 2),
                                ]),
                            child: Icon(
                              state.functions == Functions.repeatAll
                                  ? Icons.repeat
                                  : (state.functions == Functions.repeatThis
                                      ? Icons.repeat_one
                                      : Icons.shuffle),
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            context.read<PlayingMusicBloc>().add(
                                  EditIndex(
                                    calc: "-",
                                    player: widget.audioPlayer,
                                    isFinished: false,
                                  ),
                                );
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                color: const Color(0xFF4B7FD6),
                                borderRadius: BorderRadius.circular(10),
                                // border: Border.all(
                                //     color: Colors.green.withOpacity(0.4),
                                //     width: 1),
                                boxShadow: const [
                                  BoxShadow(color: Colors.blue, blurRadius: 2),
                                ]),
                            child: const Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                              size: 27,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<PlayingMusicBloc>().add(IsPlay());
                            if (state.isPlay) {
                              widget.audioPlayer.play();
                            } else {
                              widget.audioPlayer.pause();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 15, bottom: 15),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF4B7FD6),
                                boxShadow: [
                                  BoxShadow(color: Colors.blue, blurRadius: 8),
                                ]),
                            child: Icon(
                              state.isPlay
                                  ? Icons.play_arrow_rounded
                                  : Icons.pause_rounded,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            context.read<PlayingMusicBloc>().add(
                                  EditIndex(
                                    calc: "+",
                                    player: widget.audioPlayer,
                                    isFinished: false,
                                  ),
                                );
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 12, right: 12, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                color: const Color(0xFF4B7FD6),
                                borderRadius: BorderRadius.circular(10),
                                // border: Border.all(
                                //     color: Colors.green.withOpacity(0.4),
                                //     width: 1),
                                boxShadow: const [
                                  BoxShadow(color: Colors.blue, blurRadius: 2),
                                ]),
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                              size: 27,
                            ),
                          ),
                        ),
                        downloadButtonIsDisabled!
                            ? Container(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 7, bottom: 7),
                                decoration: BoxDecoration(
                                    color: const Color(0xFF4B7FD6)
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10),
                                    // border: Border.all(
                                    //     color: Colors.green.withOpacity(0.4),
                                    //     width: 1),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.blue, blurRadius: 2),
                                    ]),
                                child: Icon(
                                  Icons.file_download_rounded,
                                  color: Colors.white.withOpacity(0.4),
                                  size: 30,
                                ),
                              )
                            : GestureDetector(
                                onTap: () async {
                                  final music = state.music!;
                                  final dr =
                                      await getApplicationDocumentsDirectory();
                                  final formatIndex =
                                      music.source.lastIndexOf(".") + 1;
                                  final format =
                                      music.source.substring(formatIndex);
                                  final path = "${dr.path}/${music.id}.$format";
                                  context.read<PlayingMusicBloc>().add(
                                        DownloadMusic(
                                          url: state.music!.source,
                                          id: state.music!.id,
                                          success: (value) {
                                            context
                                                .read<PlayingMusicBloc>()
                                                .add(
                                                  AddLocalMusic(
                                                    music: PlayingMusicEntity(
                                                      id: state.music!.id,
                                                      title: state.music!.title,
                                                      album: state.music!.album,
                                                      artist:
                                                          state.music!.artist,
                                                      genre: state.music!.genre,
                                                      source:
                                                          state.music!.source,
                                                      imgurl:
                                                          state.music!.imgurl,
                                                      trackNumber: state
                                                          .music!.trackNumber,
                                                      totalTrackCount: state
                                                          .music!
                                                          .totalTrackCount,
                                                      duration:
                                                          state.music!.duration,
                                                      localMusicUrl: path,
                                                    ),
                                                  ),
                                                );
                                          },
                                        ),
                                      );
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 7, bottom: 7),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF4B7FD6),
                                      borderRadius: BorderRadius.circular(10),
                                      // border: Border.all(
                                      //     color: Colors.green.withOpacity(0.4),
                                      //     width: 1),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.blue, blurRadius: 2),
                                      ]),
                                  child: const Icon(
                                    Icons.file_download_rounded,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                      ],
                    )
                  ],
                ),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
