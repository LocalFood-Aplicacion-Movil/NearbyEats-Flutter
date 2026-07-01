import '../../domain/entities/user.dart';

class UserModel {
  final int id;
  final String username;
  final String token;

  const UserModel({required this.id, required this.username, required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as int,
        username: json['username'] as String,
        token: json['token'] as String,
      );

  User toEntity() => User(id: id, username: username, token: token);
}
