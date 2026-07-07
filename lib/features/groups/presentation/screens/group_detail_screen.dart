import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/group_provider.dart';
import '../../../../features/colleagues/presentation/providers/colleague_provider.dart';
import '../../../../features/calculations/presentation/providers/calculation_provider.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/empty_state_widget.dart';

class GroupDetailScreen extends ConsumerWidget {
  final int groupId;

  const GroupDetailScreen({super.key, required this.groupId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupAsync = ref.watch(groupByIdProvider(groupId));
    final colleaguesAsync = ref.watch(colleaguesByGroupProvider(groupId));
    final calculationsAsync = ref.watch(calculationsByGroupProvider(groupId));

    return Scaffold(
      appBar: AppBar(
        title: groupAsync.when(
          data: (g) => Text(g.name),
          loading: () => const Text('Grupo'),
          error: (_, _) => const Text('Grupo'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/groups/$groupId/colleagues/new'),
        tooltip: 'Agregar colaborador',
        child: const Icon(Icons.person_add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(colleaguesProvider);
          ref.invalidate(calculationsByGroupProvider(groupId));
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            FilledButton.icon(
              onPressed: () => context.push('/groups/$groupId/viability'),
              icon: const Icon(Icons.insights),
              label: const Text('Calcular viabilidad'),
            ),
            const SizedBox(height: 24),
            Text('Colaboradores', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            colleaguesAsync.when(
              loading: () => const LoadingWidget(),
              error: (e, _) => Text('Error: $e'),
              data: (colleagues) {
                if (colleagues.isEmpty) {
                  return const EmptyStateWidget(
                    icon: Icons.people_outline,
                    message: 'Aún no hay colaboradores en este grupo',
                  );
                }
                return Column(
                  children: colleagues
                      .map((c) => Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(c.name.isNotEmpty ? c.name[0].toUpperCase() : '?'),
                              ),
                              title: Text(c.name),
                              subtitle: Text(c.address?.city ?? c.email),
                              trailing: c.isLeader ? const Icon(Icons.star, color: Colors.amber) : null,
                            ),
                          ))
                      .toList(),
                );
              },
            ),
            const SizedBox(height: 24),
            Text('Cálculos recientes', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            calculationsAsync.when(
              loading: () => const LoadingWidget(),
              error: (e, _) => Text('Error: $e'),
              data: (calculations) {
                if (calculations.isEmpty) {
                  return const EmptyStateWidget(
                    icon: Icons.insights_outlined,
                    message: 'Aún no has calculado la viabilidad de ningún restaurante',
                  );
                }
                final sorted = [...calculations]
                  ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
                return Column(
                  children: sorted
                      .map((c) => Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: _scoreColor(c.viabilityScore),
                                child: Text('${c.viabilityScore}'),
                              ),
                              title: Text(c.restaurantName),
                              subtitle: Text(
                                'Distancia promedio: ${c.averageDistance.toStringAsFixed(2)} km · '
                                'Dispersión: ${c.maxSpread.toStringAsFixed(2)} km',
                              ),
                            ),
                          ))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _scoreColor(int score) {
    if (score >= 70) return Colors.green;
    if (score >= 40) return Colors.orange;
    return Colors.red;
  }
}
