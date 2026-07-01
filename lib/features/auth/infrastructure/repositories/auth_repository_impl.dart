import 'package:dio/dio.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';
import '../../../../core/constants/api_constants.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;

  AuthRepositoryImpl(this._dio);

  @override
  Future<User> signIn(String username, String password) async {
    final response = await _dio.post(
      ApiConstants.signIn,
      data: {'username': username, 'password': password},
    );
    return UserModel.fromJson(response.data as Map<String, dynamic>).toEntity();
  }
}
