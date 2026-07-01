class Address {
  final String street;
  final String city;
  final double latitude;
  final double longitude;

  const Address({
    required this.street,
    required this.city,
    required this.latitude,
    required this.longitude,
  });
}

class Restaurant {
  final int id;
  final String name;
  final String cuisine;
  final double rating;
  final String priceRange;
  final Address? address;
  final String phone;
  final String openHours;

  const Restaurant({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.priceRange,
    this.address,
    required this.phone,
    required this.openHours,
  });
}
