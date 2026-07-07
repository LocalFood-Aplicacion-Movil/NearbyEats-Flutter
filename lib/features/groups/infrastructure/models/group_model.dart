import '../../domain/entities/group.dart';

class GroupModel {
  final int id;
  final String name;
  final String description;
  final String color;
  final List<int> favoriteRestaurants;

  const GroupModel({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
    required this.favoriteRestaurants,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
        id: json['id'] as int,
        name: json['name'] as String? ?? '',
        description: json['description'] as String? ?? '',
        color: json['color'] as String? ?? '#4CAF50',
        favoriteRestaurants: (json['favoriteRestaurants'] as List<dynamic>?)
                ?.map((e) => e as int)
                .toList() ??
            [],
      );

  Group toEntity() => Group(
        id: id,
        name: name,
        description: description,
        color: color,
        favoriteRestaurants: favoriteRestaurants,
      );
}
