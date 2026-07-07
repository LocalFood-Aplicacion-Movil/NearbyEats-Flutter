import '../entities/calculation.dart';

abstract class CalculationRepository {
  Future<List<Calculation>> getAllByGroup(int groupId);
  Future<Calculation> create({required int groupId, required int restaurantId});
}
