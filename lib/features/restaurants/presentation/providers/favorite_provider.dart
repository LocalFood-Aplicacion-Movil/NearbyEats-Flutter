import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteNotifier extends StateNotifier<Set<int>> {
  static const _key = 'favorite_ids';

  FavoriteNotifier() : super({}) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_key) ?? [];
    state = ids.map(int.parse).toSet();
  }

  Future<void> toggle(int id) async {
    final updated = Set<int>.from(state);
    if (updated.contains(id)) {
      updated.remove(id);
    } else {
      updated.add(id);
    }
    state = updated;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, updated.map((e) => e.toString()).toList());
  }
}

final favoriteProvider = StateNotifierProvider<FavoriteNotifier, Set<int>>(
  (_) => FavoriteNotifier(),
);
