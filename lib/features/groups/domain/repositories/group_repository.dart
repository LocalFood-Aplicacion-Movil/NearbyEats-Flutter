import '../entities/group.dart';

abstract class GroupRepository {
  Future<List<Group>> getAll();
  Future<Group> getById(int id);
  Future<Group> create({
    required String name,
    required String description,
    required String color,
  });
  Future<Group> updateFavorites({
    required int id,
    required String name,
    required String description,
    required String color,
    required List<int> favoriteRestaurants,
  });
  Future<void> delete(int id);
}
