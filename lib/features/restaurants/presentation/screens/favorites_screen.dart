import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/restaurant_provider.dart';
import '../providers/favorite_provider.dart';
import '../widgets/restaurant_card.dart';
import '../../../../features/auth/presentation/providers/auth_provider.dart';
import '../../../../shared/widgets/loading_widget.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantsAsync = ref.watch(restaurantsProvider);
    final favorites = ref.watch(favoriteProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Favoritos'),
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
        data: (restaurants) {
          final favoriteList =
              restaurants.where((r) => favorites.contains(r.id)).toList();

          if (favoriteList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  const Text('No tienes favoritos aún'),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () => context.go('/restaurants'),
                    child: const Text('Explorar restaurantes'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: favoriteList.length,
            itemBuilder: (_, i) {
              final r = favoriteList[i];
              return RestaurantCard(
                restaurant: r,
                isFavorite: true,
                onToggleFavorite: () =>
                    ref.read(favoriteProvider.notifier).toggle(r.id),
              );
            },
          );
        },
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        onDestinationSelected: (i) {
          if (i == 0) context.go('/restaurants');
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
        ],
      ),
    );
  }
}
