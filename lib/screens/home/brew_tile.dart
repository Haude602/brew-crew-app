//codeof BrewTile widget ( from brew_list.dart) is defined here so that it can be modular

import 'package:flutter/material.dart';
import 'package:brew_crew/models/brew.dart';

class BrewTile extends StatelessWidget {
  final Brew brew; //final property of type Brew and name is brew
  BrewTile(
      {required this.brew}); //constructor , takes value from brew_list.dart i.e. brew

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[brew
                .strength], // as brew strength is 10 by default and can be variable as customer require
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
