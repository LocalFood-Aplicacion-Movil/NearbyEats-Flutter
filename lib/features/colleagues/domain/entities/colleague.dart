class ColleagueAddress {
  final String street;
  final String city;
  final double latitude;
  final double longitude;

  const ColleagueAddress({
    required this.street,
    required this.city,
    required this.latitude,
    required this.longitude,
  });
}

class Colleague {
  final int id;
  final String name;
  final String email;
  final String phone;
  final int? groupId;
  final bool isLeader;
  final ColleagueAddress? address;

  const Colleague({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.groupId,
    required this.isLeader,
    this.address,
  });
}
