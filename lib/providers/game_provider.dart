import 'dart:async';

import 'package:flutter/material.dart';
import 'package:leos_drinking_game/games/base_game.dart';
import 'package:leos_drinking_game/games/everyone_drinks.dart';
import 'package:leos_drinking_game/models/user_model.dart';
import 'package:leos_drinking_game/service/game_service.dart';

class GameProvider with ChangeNotifier {
  final GameService _gameService;
  List<UserModel> _users = [];
  BaseGame _currentGame = EveryoneDrinks();
  List<UserModel> _selectedUsers = [];
  String? _currentPrompt;
  bool isLoading = false;
  int countdown = 3;
  String newUserGenger = "Male";
  String newUserImoji = "😆";

  GameProvider(this._gameService);

  List<UserModel> get users {
    List<UserModel> sortedUsers = List.from(_users);
    sortedUsers
        .sort((a, b) => b.amountOfDrinksHad.compareTo(a.amountOfDrinksHad));
    return sortedUsers;
  }

  BaseGame get currentGame => _currentGame;
  List<UserModel> get selectedUsers => _selectedUsers;
  String? get currentPrompt => _currentPrompt;

  Future<void> loadUsers() async {
    _users = await _gameService.getUsers();
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
      } else {
        timer.cancel();
        loadUsers();
        startNewRound();
      }
      notifyListeners();
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
    isLoadingData();
  }

  void completeTurn() {
    isLoadingData();
    for (var user in _selectedUsers) {
      user.amountOfDrinksHad++;
      _gameService.updateUser(user);
      startNewRound();
    }
    isLoadingData();
  }
}