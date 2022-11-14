class Users {
  final String uid; //property declares

  Users({required this.uid}); // we will use UID wehn we gonna use new instances

}

// class to display user data in settings form

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData(
      {required this.uid,
      required this.sugars,
      required this.strength,
      required this.name});
}
