import 'package:dio/dio.dart';
import '../../domain/entities/group.dart';
import '../../domain/repositories/group_repository.dart';
import '../models/group_model.dart';
import '../../../../core/constants/api_constants.dart';

class GroupRepositoryImpl implements GroupRepository {
  final Dio _dio;

  GroupRepositoryImpl(this._dio);

  @override
  Future<List<Group>> getAll() async {
    final response = await _dio.get(ApiConstants.groups);
    final list = response.data as List<dynamic>;
    return list
        .map((e) => GroupModel.fromJson(e as Map<String, dynamic>).toEntity())
        .toList();
  }

  @override
  Future<Group> getById(int id) async {
    final response = await _dio.get('${ApiConstants.groups}/$id');
    return GroupModel.fromJson(response.data as Map<String, dynamic>).toEntity();
  }

  @override
  Future<Group> create({
    required String name,
    required String description,
    required String color,
  }) async {
    final response = await _dio.post(ApiConstants.groups, data: {
      'name': name,
      'description': description,
      'color': color,
    });
    return GroupModel.fromJson(response.data as Map<String, dynamic>).toEntity();
  }

  @override
  Future<Group> updateFavorites({
    required int id,
    required String name,
    required String description,
    required String color,
    required List<int> favoriteRestaurants,
  }) async {
    final response = await _dio.put('${ApiConstants.groups}/$id', data: {
      'name': name,
      'description': description,
      'color': color,
      'favoriteRestaurants': favoriteRestaurants,
    });
    return GroupModel.fromJson(response.data as Map<String, dynamic>).toEntity();
  }

  @override
  Future<void> delete(int id) async {
    await _dio.delete('${ApiConstants.groups}/$id');
  }
}
