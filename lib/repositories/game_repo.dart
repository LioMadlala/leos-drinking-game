import 'dart:math';

import 'package:leos_drinking_game/games/base_game.dart';
import 'package:leos_drinking_game/games/everyone_drinks.dart';
import 'package:leos_drinking_game/games/single_naughty_dare.dart';
import 'package:leos_drinking_game/games/multi_naughty_dare.dart';
import 'package:leos_drinking_game/games/single_naughty_question.dart';
import 'package:leos_drinking_game/games/single_soft_question.dart';
import 'package:leos_drinking_game/games/true_or_false.dart';
import 'package:leos_drinking_game/models/game_model.dart';
import 'package:leos_drinking_game/models/user_model.dart';

class UserRepository {
  final List<UserModel> _users = [
    UserModel(id: '1', name: 'Alice', gender: 'Female', imoji: "😏"),
    UserModel(id: '2', name: 'Bob', gender: 'Male', imoji: "🤗"),
    UserModel(
        id: '3', name: 'Leo', gender: 'Male', linkedWith: "Nonka", imoji: "🤣"),
    UserModel(
        id: '4', name: 'Aya', gender: 'Male', linkedWith: "Imama", imoji: "😭"),
    UserModel(
        id: '5', name: 'Zah', gender: 'Male', linkedWith: "Torry", imoji: "😆"),
    UserModel(id: '6', name: 'torry', gender: 'Male', imoji: "😎"),
  ];

  Future<List<UserModel>> getUsers() async {
    List<UserModel> users = _users;

    return users;
  }

  Future<void> addUser(UserModel user) async {
    _users.add(user);
  }

  Future<void> updateUser(UserModel user) async {
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _users[index] = user;
    }
  }
}

class GameRepository {
  var users = UserRepository()._users;

  List<BaseGame> games = [
    // EveryoneDrinks(),
    // RandomNaughtyQuestion(),
    // SingleNaughtyDare(),
    // RandomSoftQuestion(),
    // TrueOrFalse(),
    // MultiNaughtyDare(),
  ];
  Future<List<GameModel>> getGames() async {
    return games
        .map((game) => GameModel(
              id: game.type,
              name: game.name,
              type: game.type,
              numberOfPlayers: users.length,
              // numberOfPlayers: game.numberOfPlayers,
            ))
        .toList();
  }

  Future<void> addGames(List<BaseGame> gamesList) async {
    games = gamesList;
  }

  Future<BaseGame> getRandomGame() async {
    final random = Random();
    if (games.isEmpty) {
      return EveryoneDrinks();
    }
    return games[random.nextInt(games.length)];
  }
}
