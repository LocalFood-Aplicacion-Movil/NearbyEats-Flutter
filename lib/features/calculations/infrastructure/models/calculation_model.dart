import '../../domain/entities/calculation.dart';

class MemberDistanceModel {
  final int id;
  final String name;
  final double distance;

  const MemberDistanceModel({required this.id, required this.name, required this.distance});

  factory MemberDistanceModel.fromJson(Map<String, dynamic> json) => MemberDistanceModel(
        id: json['id'] as int,
        name: json['name'] as String? ?? '',
        distance: (json['distance'] as num).toDouble(),
      );

  MemberDistance toEntity() => MemberDistance(id: id, name: name, distance: distance);
}

class CalculationModel {
  final int id;
  final int groupId;
  final int restaurantId;
  final String restaurantName;
  final double distance;
  final double averageDistance;
  final double maxSpread;
  final int viabilityScore;
  final List<MemberDistanceModel> membersByDistance;
  final DateTime timestamp;

  const CalculationModel({
    required this.id,
    required this.groupId,
    required this.restaurantId,
    required this.restaurantName,
    required this.distance,
    required this.averageDistance,
    required this.maxSpread,
    required this.viabilityScore,
    required this.membersByDistance,
    required this.timestamp,
  });

  factory CalculationModel.fromJson(Map<String, dynamic> json) => CalculationModel(
        id: json['id'] as int,
        groupId: json['groupId'] as int,
        restaurantId: json['restaurantId'] as int,
        restaurantName: json['restaurantName'] as String? ?? '',
        distance: (json['distance'] as num).toDouble(),
        averageDistance: (json['averageDistance'] as num).toDouble(),
        maxSpread: (json['maxSpread'] as num).toDouble(),
        viabilityScore: json['viabilityScore'] as int,
        membersByDistance: (json['membersByDistance'] as List<dynamic>?)
                ?.map((e) => MemberDistanceModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        timestamp: DateTime.parse(json['timestamp'] as String),
      );

  Calculation toEntity() => Calculation(
        id: id,
        groupId: groupId,
        restaurantId: restaurantId,
        restaurantName: restaurantName,
        distance: distance,
        averageDistance: averageDistance,
        maxSpread: maxSpread,
        viabilityScore: viabilityScore,
        membersByDistance: membersByDistance.map((e) => e.toEntity()).toList(),
        timestamp: timestamp,
      );
}
//Correcionde seccion ejecutable del codigo