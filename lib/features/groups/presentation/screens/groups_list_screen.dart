import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/group_provider.dart';
import '../../../../features/auth/presentation/providers/auth_provider.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/empty_state_widget.dart';

class GroupsListScreen extends ConsumerWidget {
  const GroupsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsAsync = ref.watch(groupsProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Grupos'),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/groups/new'),
        child: const Icon(Icons.add),
      ),
      body: groupsAsync.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (groups) {
          if (groups.isEmpty) {
            return EmptyStateWidget(
              icon: Icons.groups_outlined,
              message: 'Aún no tienes grupos',
              buttonLabel: 'Crear grupo',
              onButtonPressed: () => context.push('/groups/new'),
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.refresh(groupsProvider.future),
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: groups.length,
              itemBuilder: (_, i) {
                final g = groups[i];
                final color = Color(int.parse(g.color.replaceFirst('#', '0xFF')));
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: color,
                      child: Text(
                        g.name.isNotEmpty ? g.name[0].toUpperCase() : '?',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(g.name),
                    subtitle: Text(
                      g.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/groups/${g.id}'),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 2,
        onDestinationSelected: (i) {
          if (i == 0) context.go('/restaurants');
          if (i == 1) context.go('/favorites');
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.restaurant), label: 'Restaurantes'),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Favoritos'),
          NavigationDestination(icon: Icon(Icons.groups), label: 'Grupos'),
        ],
      ),
    );
  }
}
