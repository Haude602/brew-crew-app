import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';

class DatabaseService {
  // inside it will be all methods and properties that we will use to interact with database or firestore

  final String? uid;
  DatabaseService({this.uid});
// collection reference ( similar to collection in firestore)
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection(
      'brew'); //it will create a collecton if it desnot exits in firestore. "brewCollection" is reference to this collection.
  // now we can red documents from collection, update, delete, using this brewCollection variable. we will add a firestore record to every new user

  //creating fucntion
  Future updateUserData(
      String sugars,
      String
          name, //this fucntion will be used twice in app. once when they first signup and second when they go to settings to update it
      int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // getting brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    //making brewlist from snapshot object and underscore to make it private. it il take QuerySnapshot

    //return list of brews
    return snapshot.docs.map((doc) {
      // this maps list of documents into another iterable s
      return Brew(
        // single brew object and below are its properties
        name: doc['name'] ?? '', // mapping and passing name key
        strength: doc['strength'] ?? 0, // return 0 if not value
        sugars: doc['sugars'] ?? '0',
      );
      //this returns iterable not list yet . so convert it into list
    }).toList();
  }

  //userData from snapshot

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    // UserData is function named as _userDataFromSnapshot()
    return UserData(
      // return user object
      uid: uid ?? '0',
      //uid: uid,
      name: snapshot['name'],
      sugars: snapshot['sugars'],
      strength: snapshot['strength'],
    );
  }

  //get brews stream (snapshot)
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // get user doc stream for displaying in settings form
  Stream<UserData> get userData {
    // stream that return  document snapshot but ultimately user data
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);

    // takes firebase stream and everytime when data is changed it takes snapshot and maps to different stream based on function _userDataFromSnapshot that return user data object
  }
}
