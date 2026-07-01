import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user.dart';
import '../../infrastructure/repositories/auth_repository_impl.dart';
import '../../../../core/network/dio_client.dart';

final authRepositoryProvider = Provider((_) => AuthRepositoryImpl(DioClient.create()));

class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;

  const AuthState({this.user, this.isLoading = false, this.error});

  AuthState copyWith({User? user, bool? isLoading, String? error}) => AuthState(
        user: user ?? this.user,
        isLoading: isLoading ?? this.isLoading,
        error: error,
      );
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepositoryImpl _repo;

  AuthNotifier(this._repo) : super(const AuthState());

  Future<bool> signIn(String username, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _repo.signIn(username, password);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', user.token);
      state = state.copyWith(isLoading: false, user: user);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Credenciales inválidas');
      return false;
    }
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    state = const AuthState();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref.read(authRepositoryProvider)),
);
