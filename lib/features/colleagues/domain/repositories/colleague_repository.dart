import '../entities/colleague.dart';

abstract class ColleagueRepository {
  Future<List<Colleague>> getAll();
  Future<Colleague> create({
    required String name,
    required String email,
    required String phone,
    required int groupId,
    required bool isLeader,
    required ColleagueAddress address,
  });
  Future<void> delete(int id);
}
