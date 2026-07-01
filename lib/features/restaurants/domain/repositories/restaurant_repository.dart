import '../entities/restaurant.dart';

abstract class RestaurantRepository {
  Future<List<Restaurant>> getAll();
}
