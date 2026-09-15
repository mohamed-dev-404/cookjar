import 'package:cookjar/core/errors/exceptions/app_exception.dart';
import 'package:cookjar/features/home/data/repos/home_repo.dart';
import 'package:cookjar/features/home/presentation/view_model/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;

  HomeCubit({required this.homeRepo}) : super(const HomeInitial());

  Future<void> fetchCurrentUser() async {
    emit(const HomeLoading());

    try {
      final user = await homeRepo.getCurrentUser();
      emit(HomeSuccess(user: user));
    } on AppException catch (e) {
      emit(HomeError(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      emit(HomeError(errorMessage: e.toString()));
    }
  }
}
