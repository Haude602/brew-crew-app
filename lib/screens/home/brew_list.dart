//This will be responsible for outputing different brews on page
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_tile.dart';

class BrewList extends StatefulWidget {
  //const BrewList({Key? key}) : super(key: key);

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);

    //print(brews?.docs); // print in terminals the instance of qerysnapshot

    // for (var i in brews.docs) {
    //   print(i.data()); // print records of each documents of each users
    // }

    //printing object properties using foreach method
    brews.forEach((brew) {
      print(brew.name);
      print(brew.sugars);
      print(brew.strength);
    });

    return ListView.builder(
      // it will create a builder to return brew list template(data) on output screen
      itemCount: brews.length, // return lenght of brew list
      itemBuilder: (content, index) {
        // it takes index and context of what item we are iterating
        //item builder is a function that return kind of templte or widget for each item in list
        return BrewTile(
            brew: brews[
                index]); //instead if coding whole templete here, we can create new widget named 'BrewTile' and pass properties and their index
      },
    );
  }
}
