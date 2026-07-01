import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/restaurant.dart';
import '../../infrastructure/repositories/restaurant_repository_impl.dart';
import '../../../../core/network/dio_client.dart';

final restaurantRepositoryProvider =
    Provider((_) => RestaurantRepositoryImpl(DioClient.create()));

final restaurantsProvider = FutureProvider<List<Restaurant>>((ref) async {
  return ref.read(restaurantRepositoryProvider).getAll();
});
