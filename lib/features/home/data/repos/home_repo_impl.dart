import 'package:cookjar/core/errors/exceptions/app_exception.dart';
import 'package:cookjar/features/home/data/data_source/home_remote_data_source.dart';
import 'package:cookjar/features/home/data/models/home_user_model.dart';
import 'package:cookjar/features/home/data/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepoImpl({required this.remoteDataSource});

  @override
  Future<HomeUserModel> getCurrentUser() async {
    try {
      return await remoteDataSource.getCurrentUser();
    } on AppException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to load home user data: ${e.toString()}');
    }
  }
}
