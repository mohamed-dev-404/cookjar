import 'package:cookjar/features/home/data/models/home_user_model.dart';

abstract class HomeRepo {
  Future<HomeUserModel> getCurrentUser();
}
