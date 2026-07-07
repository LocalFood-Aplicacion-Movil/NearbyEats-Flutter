import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/group.dart';
import '../../infrastructure/repositories/group_repository_impl.dart';
import '../../../../core/network/dio_client.dart';

final groupRepositoryProvider = Provider((_) => GroupRepositoryImpl(DioClient.create()));

final groupsProvider = FutureProvider.autoDispose<List<Group>>((ref) async {
  return ref.read(groupRepositoryProvider).getAll();
});

final groupByIdProvider =
    FutureProvider.autoDispose.family<Group, int>((ref, id) async {
  return ref.read(groupRepositoryProvider).getById(id);
});
