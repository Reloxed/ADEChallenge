import 'package:adechallenge/screens/details_venue.dart';
import 'package:adechallenge/screens/display_venues.dart';
import 'package:adechallenge/screens/map_venues.dart';
import 'package:adechallenge/screens/my_favorites.dart';
import 'package:adechallenge/screens/register.dart';
import 'package:adechallenge/screens/search_venues.dart';
import 'package:flutter/material.dart';

/* Auxiliary class where navigations inside the app are defined.*/

void navigateToRegister(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
}

void navigateToSearchVenues(BuildContext context) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => SearchVenues()), (Route<dynamic> route) => false);
}

void navigateToDisplayVenues(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayVenues()));
}

void navigateToMapVenues(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => MapVenues()));
}

void navigateToDetailedVenue(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsVenue()));
}

void navigateToMyFavorites(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => MyFavorites()));
}