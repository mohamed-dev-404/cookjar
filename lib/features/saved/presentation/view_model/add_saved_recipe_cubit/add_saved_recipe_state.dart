sealed class AddSavedRecipeState {
  const AddSavedRecipeState();
}

final class AddSavedRecipeInitial extends AddSavedRecipeState {
  const AddSavedRecipeInitial();
}

final class AddSavedRecipeLoading extends AddSavedRecipeState {
  const AddSavedRecipeLoading();
}

final class AddSavedRecipeSuccess extends AddSavedRecipeState {
  const AddSavedRecipeSuccess();
}

final class AddSavedRecipeFailure extends AddSavedRecipeState {
  final String errorMessage;
  const AddSavedRecipeFailure({required this.errorMessage});
}
