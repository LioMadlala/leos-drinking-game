import 'package:leos_drinking_game/models/user_model.dart';

class UserRepository {
  final List<UserModel> users = [];

  Future<List<UserModel>> getUsers() async {
    List<UserModel> usersList = users;

    return usersList;
  }

  Future<void> addUser(UserModel user) async {
    users.add(user);
  }

  Future<void> updateUser(UserModel user) async {
    final index = users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      users[index] = user;
    }
  }
}
