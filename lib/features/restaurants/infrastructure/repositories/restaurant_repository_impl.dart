import 'package:dio/dio.dart';
import '../../domain/entities/restaurant.dart';
import '../../domain/repositories/restaurant_repository.dart';
import '../models/restaurant_model.dart';
import '../../../../core/constants/api_constants.dart';

class RestaurantRepositoryImpl implements RestaurantRepository {
  final Dio _dio;

  RestaurantRepositoryImpl(this._dio);

  @override
  Future<List<Restaurant>> getAll() async {
    final response = await _dio.get(ApiConstants.restaurants);
    final list = response.data as List<dynamic>;
    return list
        .map((e) => RestaurantModel.fromJson(e as Map<String, dynamic>).toEntity())
        .toList();
  }
}
