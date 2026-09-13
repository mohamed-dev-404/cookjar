import 'package:cookjar/core/errors/exceptions/app_exception.dart';
import 'package:cookjar/features/auth/data/repos/auth_repo.dart';
import 'package:cookjar/features/auth/presentation/login/view_model/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;

  LoginCubit({required this.authRepo}) : super(const LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(const LoginLoading());

    try {
      await authRepo.login(email: email, password: password);
      emit(const LoginSuccess());
    } on AppException catch (e) {
      emit(LoginError(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      emit(LoginError(errorMessage: e.toString()));
    }
  }
}
