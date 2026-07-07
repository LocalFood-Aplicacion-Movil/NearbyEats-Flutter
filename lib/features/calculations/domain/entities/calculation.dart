class MemberDistance {
  final int id;
  final String name;
  final double distance;

  const MemberDistance({required this.id, required this.name, required this.distance});
}

class Calculation {
  final int id;
  final int groupId;
  final int restaurantId;
  final String restaurantName;
  final double distance;
  final double averageDistance;
  final double maxSpread;
  final int viabilityScore;
  final List<MemberDistance> membersByDistance;
  final DateTime timestamp;

  const Calculation({
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
}
