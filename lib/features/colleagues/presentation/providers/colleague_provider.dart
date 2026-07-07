import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/colleague.dart';
import '../../infrastructure/repositories/colleague_repository_impl.dart';
import '../../../../core/network/dio_client.dart';

final colleagueRepositoryProvider =
    Provider((_) => ColleagueRepositoryImpl(DioClient.create()));

final colleaguesProvider = FutureProvider.autoDispose<List<Colleague>>((ref) async {
  return ref.read(colleagueRepositoryProvider).getAll();
});

final colleaguesByGroupProvider =
    FutureProvider.autoDispose.family<List<Colleague>, int>((ref, groupId) async {
  final all = await ref.watch(colleaguesProvider.future);
  return all.where((c) => c.groupId == groupId).toList();
});
