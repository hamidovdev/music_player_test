import 'package:music_player_test/core/either/either.dart';
import 'package:music_player_test/core/failure/failure.dart';

abstract class UseCase<Type, Params> {
  const UseCase();

  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
