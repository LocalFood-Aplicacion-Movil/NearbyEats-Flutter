import '../../domain/entities/colleague.dart';

class ColleagueAddressModel {
  final String street;
  final String city;
  final double latitude;
  final double longitude;

  const ColleagueAddressModel({
    required this.street,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  factory ColleagueAddressModel.fromJson(Map<String, dynamic> json) => ColleagueAddressModel(
        street: json['street'] as String? ?? '',
        city: json['city'] as String? ?? '',
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
      );

  ColleagueAddress toEntity() =>
      ColleagueAddress(street: street, city: city, latitude: latitude, longitude: longitude);
}

class ColleagueModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final int? groupId;
  final bool isLeader;
  final ColleagueAddressModel? address;

  const ColleagueModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.groupId,
    required this.isLeader,
    this.address,
  });

  factory ColleagueModel.fromJson(Map<String, dynamic> json) => ColleagueModel(
        id: json['id'] as int,
        name: json['name'] as String? ?? '',
        email: json['email'] as String? ?? '',
        phone: json['phone'] as String? ?? '',
        groupId: json['groupId'] as int?,
        isLeader: json['isLeader'] as bool? ?? false,
        address: json['address'] != null
            ? ColleagueAddressModel.fromJson(json['address'] as Map<String, dynamic>)
            : null,
      );

  Colleague toEntity() => Colleague(
        id: id,
        name: name,
        email: email,
        phone: phone,
        groupId: groupId,
        isLeader: isLeader,
        address: address?.toEntity(),
      );
}
