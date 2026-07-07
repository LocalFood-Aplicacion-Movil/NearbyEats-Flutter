import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/calculation.dart';
import '../../infrastructure/repositories/calculation_repository_impl.dart';
import '../../../../core/network/dio_client.dart';

final calculationRepositoryProvider =
    Provider((_) => CalculationRepositoryImpl(DioClient.create()));

final calculationsByGroupProvider =
    FutureProvider.autoDispose.family<List<Calculation>, int>((ref, groupId) async {
  return ref.read(calculationRepositoryProvider).getAllByGroup(groupId);
});
