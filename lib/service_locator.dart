import 'package:get_it/get_it.dart';
import 'package:tune_box/data/repository_implementation/auth/auth_repository_implementation.dart';
import 'package:tune_box/data/sources/auth/auth_firebase_service.dart';
import 'package:tune_box/domain/repository/auth/auth_repository.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl()
  );

  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImplementation()
  );

}
