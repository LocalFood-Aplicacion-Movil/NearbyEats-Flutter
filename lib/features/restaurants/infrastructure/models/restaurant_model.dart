import '../../domain/entities/restaurant.dart';

class AddressModel {
  final String street;
  final String city;
  final double latitude;
  final double longitude;

  const AddressModel({
    required this.street,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        street: json['street'] as String? ?? '',
        city: json['city'] as String? ?? '',
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
      );

  Address toEntity() => Address(street: street, city: city, latitude: latitude, longitude: longitude);
}

class RestaurantModel {
  final int id;
  final String name;
  final String cuisine;
  final double rating;
  final String priceRange;
  final AddressModel? address;
  final String phone;
  final String openHours;

  const RestaurantModel({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.priceRange,
    this.address,
    required this.phone,
    required this.openHours,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) => RestaurantModel(
        id: json['id'] as int,
        name: json['name'] as String? ?? '',
        cuisine: json['cuisine'] as String? ?? '',
        rating: (json['rating'] as num).toDouble(),
        priceRange: json['priceRange'] as String? ?? '',
        address: json['address'] != null
            ? AddressModel.fromJson(json['address'] as Map<String, dynamic>)
            : null,
        phone: json['phone'] as String? ?? '',
        openHours: json['openHours'] as String? ?? '',
      );

  Restaurant toEntity() => Restaurant(
        id: id,
        name: name,
        cuisine: cuisine,
        rating: rating,
        priceRange: priceRange,
        address: address?.toEntity(),
        phone: phone,
        openHours: openHours,
      );
}
