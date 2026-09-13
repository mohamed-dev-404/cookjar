abstract class AuthRepo {
  Future<void> register({
    required String name,
    required String email,
    required String password,
  });

  Future<void> login({required String email, required String password});
}
