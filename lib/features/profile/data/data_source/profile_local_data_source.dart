import 'package:cookjar/core/errors/exceptions/app_exception.dart';
import 'package:cookjar/core/errors/models/error_model.dart';

abstract class ProfileLocalDataSource {
  Future<int> getSavedRecipesCount();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  @override
  Future<int> getSavedRecipesCount() async {
    try {
      // In full implementation, retrieve box length from Hive local box:
      // final box = Hive.box('saved_recipes');
      // return box.length;
      return 0; // Default saved recipes count for demo / local storage
    } catch (e) {
      throw ProfileLocalException(
        errorModel: ErrorModel(
          errorMessage: 'Failed to read local saved recipes: ${e.toString()}',
        ),
      );
    }
  }
}

class ProfileLocalException extends AppException {
  ProfileLocalException({required super.errorModel});
}
