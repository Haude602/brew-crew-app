// it contains any constants taht we will use in future or code that need to be repeated
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    // creating constant named textInputDecoration for decoration code in input field of signin.dart and register.dart
    // for decorating input fields
    //hintText: 'Email', // as this cant be constant in password field. so use ".copywith(hintText: 'Email'" for email
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.pink, width: 2.0)));
