import 'package:dio/dio.dart';
import '../../domain/entities/calculation.dart';
import '../../domain/repositories/calculation_repository.dart';
import '../models/calculation_model.dart';
import '../../../../core/constants/api_constants.dart';

class CalculationRepositoryImpl implements CalculationRepository {
  final Dio _dio;

  CalculationRepositoryImpl(this._dio);

  @override
  Future<List<Calculation>> getAllByGroup(int groupId) async {
    final response = await _dio.get(ApiConstants.calculations, queryParameters: {
      'groupId': groupId,
    });
    final list = response.data as List<dynamic>;
    return list
        .map((e) => CalculationModel.fromJson(e as Map<String, dynamic>).toEntity())
        .toList();
  }

  @override
  Future<Calculation> create({required int groupId, required int restaurantId}) async {
    final response = await _dio.post(ApiConstants.calculations, data: {
      'groupId': groupId,
      'restaurantId': restaurantId,
    });
    return CalculationModel.fromJson(response.data as Map<String, dynamic>).toEntity();
  }
}
