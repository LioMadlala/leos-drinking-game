class UserModel {
  final String id;
  final String name;
  int amountOfDrinksHad;
  final String gender;
  final String imoji;
  String? linkedWith;

  UserModel({
    required this.id,
    required this.name,
    required this.imoji,
    this.amountOfDrinksHad = 0,
    required this.gender,
    this.linkedWith,
  });
}
