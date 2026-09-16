import 'package:cookjar/features/saved/data/repositories/saved_repo.dart';
import 'package:cookjar/features/saved/presentation/view_model/saved_recipes_cubit/saved_recipes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedRecipesCubit extends Cubit<SavedRecipesState> {
  SavedRecipesCubit({required this.savedRepo})
    : super(const SavedRecipesInitial());

  final SavedRepo savedRepo;

  Future<void> getSavedRecipes() async {
    emit(const SavedRecipesLoading());

    final result = await savedRepo.getSavedRecipes();

    result.fold(
      (errorMessage) => emit(SavedRecipesFailure(errorMessage: errorMessage)),
      (recipes) => emit(SavedRecipesSuccess(recipes: recipes)),
    );
  }
}
