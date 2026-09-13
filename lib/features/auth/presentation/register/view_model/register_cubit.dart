import 'package:cookjar/core/errors/exceptions/app_exception.dart';
import 'package:cookjar/features/auth/data/repos/auth_repo.dart';
import 'package:cookjar/features/auth/presentation/register/view_model/register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo authRepo;

  RegisterCubit({required this.authRepo}) : super(const RegisterInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const RegisterLoading());

    try {
      await authRepo.register(name: name, email: email, password: password);
      emit(const RegisterSuccess());
    } on AppException catch (e) {
      emit(RegisterError(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      emit(RegisterError(errorMessage: e.toString()));
    }
  }
}
