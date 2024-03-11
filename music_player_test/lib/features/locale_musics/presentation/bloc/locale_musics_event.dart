part of 'locale_musics_bloc.dart';

abstract class LocaleMusicsEvent {}

class AddLocalMusic extends LocaleMusicsEvent {
  final LocaleMusicsEntity music;

  AddLocalMusic({required this.music});
}

class GetLocalMusics extends LocaleMusicsEvent {}
