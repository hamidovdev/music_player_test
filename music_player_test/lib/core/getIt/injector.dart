import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.I;

Future<void> getItInjector() async {
  serviceLocator
      .registerLazySingleton(() async => await SharedPreferences.getInstance());
}
