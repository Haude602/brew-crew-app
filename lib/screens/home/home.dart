import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/models/brew.dart';

class Home extends StatelessWidget {
  //const ({ Key? key }) : super(key: key);
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    // defining code inside funxction _showsettingsPanel that will open form to edit details for users
    void _showSettingsPanel() {
      showModalBottomSheet(
          //builtin function of flutter to show bottom sheet
          context: context,
          builder: (context) {
            // this builder is going to be our form to update user data and is template inside bottom sheet
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      // .value to indicate what is value of stream will be list of brew
      value: DatabaseService().brews, // value is property
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('BrewCrew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              onPressed: () async {
                await _auth.signOut(); //signOut is firebase builtin method
              },
              label: Text('logout'),
            ),

            //button for updating records
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () =>
                  _showSettingsPanel(), // this is function we will create above  in build method
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/coffee_bg.png'), // adding background image to main screen
                fit: BoxFit.cover,
              ),
            ),
            child:
                BrewList()), // for displaying snapshot of collection that we made above along with scaffold body of content
      ),
    );
  }
}
