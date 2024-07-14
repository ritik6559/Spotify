import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tune_box/data/models/song/song_model.dart';
import 'package:tune_box/domain/entities/song/song_entity.dart';
import 'package:tune_box/domain/usecases/song/is_favorite_song.dart';
import 'package:tune_box/service_locator.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavoriteSong(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSongs();
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('release', descending: true)
          .limit(3)
          .get();

      for (var element in data.docs) {
        var song = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUseCase>()
            .call(params: element.reference.id);
        song.isFavorite = isFavorite;
        song.songId = element.reference.id;
        songs.add(
          song.toEntity(),
        );
      }
      return Right(songs);
    } catch (e) {
      return const Left("An error occured.");
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('release', descending: true)
          .get();

      for (var element in data.docs) {
        var song = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUseCase>()
            .call(params: element.reference.id);
        song.isFavorite = isFavorite;
        song.songId = element.reference.id;
        songs.add(
          song.toEntity(),
        );
      }
      return Right(songs);
    } catch (e) {
      return const Left("An error occured.");
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      late bool isFvorite;

      var user = firebaseAuth.currentUser;
      String uid = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .where('songId', isEqualTo: songId)
          .get();
      if (favoriteSongs.docs.isNotEmpty) {
        await favoriteSongs.docs.first.reference.delete();
        isFvorite = false;
      } else {
        await firebaseFirestore
            .collection('users')
            .doc(uid)
            .collection('favorites')
            .add({
          'songId': songId,
          'addedDate': Timestamp.now(),
        });
        isFvorite = true;
      }
      return Right(isFvorite);
    } catch (e) {
      return const Left("An error occured");
    }
  }

  @override
  Future<bool> isFavoriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;
      String uid = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .where('songId', isEqualTo: songId)
          .get();
      if (favoriteSongs.docs.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
  
  @override
  Future < Either > getUserFavoriteSongs() async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;
      List<SongEntity> favoriteSongs = [];
      String uId = user!.uid;
      QuerySnapshot favoritesSnapshot = await firebaseFirestore.collection(
        'users'
      ).doc(uId)
      .collection('favorites')
      .get();
      
      for (var element in favoritesSnapshot.docs) { 
        String songId = element['songId'];
        var song = await firebaseFirestore.collection('Songs').doc(songId).get();
        SongModel songModel = SongModel.fromJson(song.data()!);
        songModel.isFavorite = true;
        songModel.songId = songId;
        favoriteSongs.add(
          songModel.toEntity()
        );
      }
      
      return Right(favoriteSongs);

    } catch (e) {
      print(e);
      return const Left(
        'An error occurred'
      );
    }
  }
}
