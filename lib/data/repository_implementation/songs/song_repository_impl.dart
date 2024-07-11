import 'package:dartz/dartz.dart';
import 'package:tune_box/data/sources/songs/song_firebase_service.dart';
import 'package:tune_box/domain/repository/song/song_repository.dart';
import 'package:tune_box/service_locator.dart';

class SongRepositoryImpl extends SongRepository {
  @override
  Future<Either> getNewsSongs() async{
    return await sl<SongFirebaseService>().getNewsSongs();
  }
}
