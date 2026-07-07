import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/restaurant_provider.dart';
import '../providers/favorite_provider.dart';
import '../widgets/restaurant_card.dart';
import '../../../../features/auth/presentation/providers/auth_provider.dart';
import '../../../../shared/widgets/loading_widget.dart';

class RestaurantListScreen extends ConsumerWidget {
  const RestaurantListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantsAsync = ref.watch(restaurantsProvider);
    final favorites = ref.watch(favoriteProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Restaurantes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authProvider.notifier).signOut();
              if (context.mounted) context.go('/login');
            },
          ),
        ],
      ),
      body: restaurantsAsync.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (restaurants) => RefreshIndicator(
          onRefresh: () => ref.refresh(restaurantsProvider.future),
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: restaurants.length,
            itemBuilder: (_, i) {
              final r = restaurants[i];
              return RestaurantCard(
                restaurant: r,
                isFavorite: favorites.contains(r.id),
                onToggleFavorite: () =>
                    ref.read(favoriteProvider.notifier).toggle(r.id),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (i) {
          if (i == 1) context.go('/favorites');
          if (i == 2) context.go('/groups');
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.restaurant),
            label: 'Restaurantes',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups),
            label: 'Grupos',
          ),
        ],
      ),
    );
  }
}
