import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/calculation.dart';
import '../providers/calculation_provider.dart';
import '../../../restaurants/presentation/providers/restaurant_provider.dart';
import '../../../../shared/widgets/loading_widget.dart';

class ViabilityScreen extends ConsumerStatefulWidget {
  final int groupId;

  const ViabilityScreen({super.key, required this.groupId});

  @override
  ConsumerState<ViabilityScreen> createState() => _ViabilityScreenState();
}

class _ViabilityScreenState extends ConsumerState<ViabilityScreen> {
  int? _calculatingRestaurantId;
  Calculation? _result;
  String? _error;

  Future<void> _calculate(int restaurantId) async {
    setState(() {
      _calculatingRestaurantId = restaurantId;
      _error = null;
    });
    try {
      final calculation = await ref.read(calculationRepositoryProvider).create(
            groupId: widget.groupId,
            restaurantId: restaurantId,
          );
      ref.invalidate(calculationsByGroupProvider(widget.groupId));
      setState(() => _result = calculation);
    } catch (e) {
      setState(() => _error = 'No se pudo calcular la viabilidad: $e');
    } finally {
      setState(() => _calculatingRestaurantId = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final restaurantsAsync = ref.watch(restaurantsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Calcular viabilidad')),
      body: restaurantsAsync.when(
        loading: () => const LoadingWidget(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (restaurants) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            if (_result != null) _ResultCard(result: _result!),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              ),
            Text('Elige un restaurante', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            ...restaurants.map((r) => Card(
                  child: ListTile(
                    title: Text(r.name),
                    subtitle: Text(r.address?.city ?? r.cuisine),
                    trailing: _calculatingRestaurantId == r.id
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.chevron_right),
                    onTap: _calculatingRestaurantId != null ? null : () => _calculate(r.id),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final Calculation result;

  const _ResultCard({required this.result});

  Color _scoreColor(int score) {
    if (score >= 70) return Colors.green;
    if (score >= 40) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final sortedMembers = [...result.membersByDistance]
      ..sort((a, b) => a.distance.compareTo(b.distance));

    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(result.restaurantName, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: _scoreColor(result.viabilityScore),
                  child: Text(
                    '${result.viabilityScore}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Puntaje de viabilidad', style: Theme.of(context).textTheme.bodyMedium),
                      Text(
                        'Distancia promedio: ${result.averageDistance.toStringAsFixed(2)} km',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        'Dispersión: ${result.maxSpread.toStringAsFixed(2)} km',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Distancia por colaborador', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 4),
            ...sortedMembers.map(
              (m) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(m.name),
                    Text('${m.distance.toStringAsFixed(2)} km'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
