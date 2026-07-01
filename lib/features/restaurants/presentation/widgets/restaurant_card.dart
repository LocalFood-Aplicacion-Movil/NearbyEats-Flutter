import 'package:flutter/material.dart';
import '../../domain/entities/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final initial = restaurant.name.isNotEmpty ? restaurant.name[0].toUpperCase() : '?';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          child: Text(initial, style: TextStyle(color: colorScheme.onPrimaryContainer)),
        ),
        title: Text(restaurant.name),
        subtitle: Text(
          restaurant.address?.street ?? restaurant.cuisine,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? colorScheme.error : null,
          ),
          onPressed: onToggleFavorite,
        ),
      ),
    );
  }
}
