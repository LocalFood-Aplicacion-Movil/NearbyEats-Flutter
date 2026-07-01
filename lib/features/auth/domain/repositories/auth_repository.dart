import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> signIn(String username, String password);
}
