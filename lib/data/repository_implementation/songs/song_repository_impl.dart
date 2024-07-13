import 'package:dartz/dartz.dart';
import 'package:tune_box/data/sources/songs/song_firebase_service.dart';
import 'package:tune_box/domain/repository/song/song_repository.dart';
import 'package:tune_box/service_locator.dart';

class SongRepositoryImpl extends SongsRepository {

  @override
  Future<Either> getNewsSongs() async {
    return await sl<SongFirebaseService>().getNewsSongs();
  }
  
  @override
  Future<Either> getPlayList() async{
    
    return await sl<SongFirebaseService>().getPlayList();
  }
  
  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) {
    // TODO: implement addOrRemoveFavoriteSong
    throw UnimplementedError();
  }
  
  @override
  Future<bool> isFavoriteSong(String songId) {
    // TODO: implement isFavoriteSong
    throw UnimplementedError();
  }
}
