import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import 'package:brew_crew/shared/constants.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<
      FormState>(); // we will use form inside widet for which we need global key
  final List<String> sugars = ['0', '1', '2', '3', '4']; // list of string

  //form values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    //creating form to take inputs from user and wraping it with stream builder and passing UserData as object
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid)
          .userData, // stream data based on user id
      builder: (context, snapshot) {
        //check is snapshot has data
        if (snapshot.hasData) {
          // thiis returns true or false whether snapshot has data or not from firebase
          UserData? userData = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your brew settings.', // title of the form
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData!
                      .name, // to show in settings form the userData value as default value
                  decoration: textInputDecoration,
                  validator: (val) => val!.isEmpty
                      ? 'Please enter a name'
                      : null, // ensures that we have a a value
                  onChanged: (val) => setState(() => _currentName = val),
                ),

                SizedBox(height: 20.0),

                //dropdown for sugars
                DropdownButtonFormField(
                  decoration: textInputDecoration, // to decorate input text
                  value: _currentSugars ??
                      userData
                          .sugars, // shows what value we select in input field in dropdown. Takes value from UserData
                  items: sugars.map((sugar) {
                    // values hould be from list of vlaues i sugars properties
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(), // items expects list of values. so iterate through each sugar values
                  onChanged: (val) => setState(() => _currentSugars = val
                      as String), // selected values will be assigned to currentSugars
                ),

                // creating slider widget  for field of strength of coffee

                Slider(
                  value: (_currentStrength ??
                          userData
                              .strength) // if not value then start with userData from firebase user
                      .toDouble(), // convert value of stregth to double from int that can be assigned belw to val

                  // asisgning color to slider
                  activeColor: Colors.brown[_currentStrength ??
                      userData
                          .strength], // we pass default value of color as 100 as we cant pas snull to it
                  inactiveColor:
                      Colors.brown[_currentStrength ?? userData.strength],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) =>
                      setState(() => _currentStrength = val.round()),
                ),

                //slider
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    // allowing form to update data in firestore after validation using updateUserData function
                    if (_formKey.currentState!.validate()) {
                      // check the current state validation
                      // now save to database after validation
                      await DatabaseService(uid: user.uid).updateUserData(
                        // we need to await this as it will take some time and create databaseservie instant and pass uid which will be useruid
                        // this instance will used to update data using updatedata function
                        _currentSugars ??
                            userData
                                .sugars, // ?? is used to chekc it has already value or take from userdata
                        _currentName ?? userData.name,
                        _currentStrength ?? userData.strength,
                      );
                      // shut the form after updating
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          );
        } else {
          Loading();
        }
        return Text("No widget to build");
      },
    );
  }
}
