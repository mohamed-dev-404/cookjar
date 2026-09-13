import 'package:cookjar/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:cookjar/features/auth/data/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepoImpl({required this.remoteDataSource});

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await remoteDataSource.registerWithEmailAndPassword(
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  Future<void> login({required String email, required String password}) async {
    await remoteDataSource.loginWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
