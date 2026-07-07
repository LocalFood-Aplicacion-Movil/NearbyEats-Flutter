import 'package:dio/dio.dart';
import '../../domain/entities/colleague.dart';
import '../../domain/repositories/colleague_repository.dart';
import '../models/colleague_model.dart';
import '../../../../core/constants/api_constants.dart';

class ColleagueRepositoryImpl implements ColleagueRepository {
  final Dio _dio;

  ColleagueRepositoryImpl(this._dio);

  @override
  Future<List<Colleague>> getAll() async {
    final response = await _dio.get(ApiConstants.colleagues);
    final list = response.data as List<dynamic>;
    return list
        .map((e) => ColleagueModel.fromJson(e as Map<String, dynamic>).toEntity())
        .toList();
  }

  @override
  Future<Colleague> create({
    required String name,
    required String email,
    required String phone,
    required int groupId,
    required bool isLeader,
    required ColleagueAddress address,
  }) async {
    final response = await _dio.post(ApiConstants.colleagues, data: {
      'name': name,
      'email': email,
      'phone': phone,
      'groupId': groupId,
      'isLeader': isLeader,
      'address': {
        'street': address.street,
        'city': address.city,
        'latitude': address.latitude,
        'longitude': address.longitude,
      },
    });
    return ColleagueModel.fromJson(response.data as Map<String, dynamic>).toEntity();
  }

  @override
  Future<void> delete(int id) async {
    await _dio.delete('${ApiConstants.colleagues}/$id');
  }
}
