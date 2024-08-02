import 'package:leos_drinking_game/games/base_game.dart';
import 'package:leos_drinking_game/models/user_model.dart';
import 'package:leos_drinking_game/repositories/game_repo.dart';

class GameService {
  final UserRepository _userRepository;
  final GameRepository _gameRepository;

  GameService(this._userRepository, this._gameRepository);

  Future<List<UserModel>> getUsers() => _userRepository.getUsers();
  Future<void> addUser(UserModel user) => _userRepository.addUser(user);
  Future<void> updateUser(UserModel user) => _userRepository.updateUser(user);
  Future<BaseGame> getRandomGame() => _gameRepository.getRandomGame();

  Future<List<UserModel>> selectRandomUsers(int count) async {
    final users = await getUsers();
    users.shuffle();
    List<UserModel> selectedUsers = users.take(count).toList();
    if (selectedUsers.length != count) {
      return selectRandomUsers(count);
    }
    return selectedUsers;
  }
}
