import 'package:adechallenge/screens/register.dart';
import 'package:adechallenge/screens/search_venues.dart';
import 'package:flutter/material.dart';

void navigateToRegister(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
}

void navigateToSearchVenues(BuildContext context) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => SearchVenues()), (Route<dynamic> route) => false);
}
