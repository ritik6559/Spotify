import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tune_box/data/models/song/song_model.dart';
import 'package:tune_box/domain/entities/song/song_entity.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavoriteSong(String songId);
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
}