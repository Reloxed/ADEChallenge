import 'package:adechallenge/models/detailed_venue.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/* This file defines the methods that retrieve some data from the Firestore database */

/// Retrieves favorite venues of current user from the Firestore database.
Future<List<DetailedVenue>> getFavorites() async {
  List<DetailedVenue> _venues = [];

  await FirebaseFirestore.instance
      .collection("favorites")
      .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((venues) => venues.docs.forEach((element) {
            DetailedVenue detailedVenue = DetailedVenue.detailedVenueFromDatabase(element.data()['detailedVenue']);
            _venues.add(detailedVenue);
          }));

  return _venues;
}

/// Retrieves if a venue has been saved on favorites for the current user.
Future<bool> isVenueFavorite(String id) async {
  bool isFavorite = false;

  await FirebaseFirestore.instance
      .collection("favorites")
      .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((venues) {
        for(int i = 0; i < venues.docs.length; i++) {
          if(venues.docs[i].data()['detailedVenue']['id'] == id) {
            isFavorite = true;
            break;
          }
        }
  });
  return isFavorite;
}
