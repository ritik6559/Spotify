import 'package:dartz/dartz.dart';
import 'package:tune_box/core/usecases/usecase.dart';
import 'package:tune_box/domain/repository/song/song_repository.dart';
import 'package:tune_box/service_locator.dart';

class GetNewsSongsUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async{
    return sl<SongRepository>().getNewsSongs();
  }
}
