import 'dart:async';

import 'package:flutter/material.dart';
import 'package:leos_drinking_game/games/base_game.dart';
import 'package:leos_drinking_game/games/everyone_drinks.dart';
import 'package:leos_drinking_game/games/multi_truth_or_drink.dart';
import 'package:leos_drinking_game/models/user_model.dart';
import 'package:leos_drinking_game/service/game_service.dart';

class GameProvider with ChangeNotifier {
  final GameService _gameService;
  List<UserModel> _users = [];
  BaseGame _currentGame = EveryoneDrinks();
  List<UserModel> _selectedUsers = [];
  List<UserModel> whoDrinks = [];
  String? _currentPrompt;
  bool isLoading = false;
  int countdown = 3;
  String newUserGenger = "Male";
  String newUserImoji = "😆";

  GameProvider(this._gameService);

  List<UserModel> get users {
    loadUsers();
    List<UserModel> sortedUsers = List.from(_users);
    sortedUsers
        .sort((a, b) => b.amountOfDrinksHad.compareTo(a.amountOfDrinksHad));
    return sortedUsers;
  }

  addGames(List<BaseGame> games) {
    _gameService.addGames(games);
  }

  BaseGame get currentGame => _currentGame;
  List<UserModel> get selectedUsers => _selectedUsers;
  String? get currentPrompt => _currentPrompt;

  Future<void> loadUsers() async {
    _users = await _gameService.getUsers();
    notifyListeners();
  }

  gameWithPrompt() {
    if (currentGame is MultiTruthOrDrink) {
      _selectedUsers = _users;
    }
    return GameWithPrompt(
      name: currentGame.name,
      type: currentGame.type,
      prompt: currentPrompt ?? '',
      numberOfPlayers: currentGame.numberOfPlayers,
    );
  }

  selectedUsersForGames() async {
    if (currentGame is MultiTruthOrDrink) {
      // _selectedUsers = _users;
      _selectedUsers = await _gameService.selectRandomUsers(_users.length);
    } else {
      _selectedUsers =
          await _gameService.selectRandomUsers(_currentGame.numberOfPlayers);
    }
    notifyListeners();
  }

  isLoadingData() {
    isLoading = isLoading ? false : true;
    notifyListeners();
  }

  startGame() {
    countdown = 2;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        countdown--;
        notifyListeners();
      } else {
        timer.cancel();
        loadUsers();
        startNewRound();
      }
    });
  }

  Future<void> addUser(String name) async {
    isLoadingData();

    final newUser = UserModel(
      id: DateTime.now().toString(),
      name: name,
      gender: newUserGenger,
      imoji: newUserImoji,
    );
    await _gameService.addUser(newUser);
    isLoadingData();
  }

  updateNewUserGender(String gender) {
    newUserGenger = gender;
    notifyListeners();
  }

  updateNewUserImoji(String imoji) {
    newUserImoji = imoji;
    notifyListeners();
  }

  Future<void> startNewRound() async {
    isLoadingData();
    _currentGame = await _gameService.getRandomGame();
    _selectedUsers =
        await _gameService.selectRandomUsers(_currentGame.numberOfPlayers);
    _currentPrompt = _currentGame.getPrompt(_selectedUsers);
    whoDrinks.clear();
    isLoadingData();
  }

  addToDrink(UserModel user) {
    if (whoDrinks.contains(user)) {
      whoDrinks.remove(user);
    } else {
      whoDrinks.add(user);
    }
    notifyListeners();
  }

  checkWhoDrinks() {
    for (var user in whoDrinks) {
      user.amountOfDrinksHad++;
      _gameService.updateUser(user);
    }
  }

  void completeTurn() {
    isLoadingData();
    checkWhoDrinks();
    startNewRound();
    isLoadingData();
  }
}
