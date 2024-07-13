import 'package:get_it/get_it.dart';
import 'package:tune_box/data/repository_implementation/auth/auth_repository_implementation.dart';
import 'package:tune_box/data/repository_implementation/songs/song_repository_impl.dart';
import 'package:tune_box/data/sources/auth/auth_firebase_service.dart';
import 'package:tune_box/data/sources/songs/song_firebase_service.dart';
import 'package:tune_box/domain/repository/auth/auth_repository.dart';
import 'package:tune_box/domain/repository/song/song_repository.dart';
import 'package:tune_box/domain/usecases/auth/signin_usecase.dart';
import 'package:tune_box/domain/usecases/auth/signup_usecase.dart';
import 'package:tune_box/domain/usecases/song/add_remove_favorite_use_case.dart';
import 'package:tune_box/domain/usecases/song/get_news_songs.dart';
import 'package:tune_box/domain/usecases/song/get_playlist.dart';
import 'package:tune_box/domain/usecases/song/is_favorite_song.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {


  sl.registerSingleton<AuthFirebaseService>(
  AuthFirebaseServiceImpl()
 );

 sl.registerSingleton<SongFirebaseService>(
  SongFirebaseServiceImpl()
 );
 

 sl.registerSingleton<AuthRepository>(
  AuthRepositoryImplementation()
 );

 sl.registerSingleton<SongsRepository>(
  SongRepositoryImpl()
 );

 sl.registerSingleton<SignupUsecase>(
  SignupUsecase()
 );

 sl.registerSingleton<SigninUsecase>(
  SigninUsecase()
 );

 sl.registerSingleton<GetNewsSongsUseCase>(
  GetNewsSongsUseCase()
 );

 sl.registerSingleton<GetPlayListUseCase>(
  GetPlayListUseCase()
 );

 sl.registerSingleton<AddOrRemoveFavoriteUseCase>(
  AddOrRemoveFavoriteUseCase()
 );

 sl.registerSingleton<IsFavoriteSongUseCase>(
  IsFavoriteSongUseCase()
 );
}

