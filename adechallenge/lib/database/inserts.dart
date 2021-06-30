import 'package:adechallenge/models/detailed_venue.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*This file defines the methods that insert some data in the Firestore database */

/// Add a new document to the favorites collection of the Firestore database.
Future<bool> saveFavorites(DetailedVenue detailedVenue) async {
  await FirebaseFirestore.instance
      .collection("favorites")
      .add({"userId": FirebaseAuth.instance.currentUser!.uid, "detailedVenue": detailedVenue.detailedVenueToJson()});
  return true;
}

/// Deletes a given document from the favorites collection of the Firestore database.
Future<bool> deleteFavorites(String id) async {
  await FirebaseFirestore.instance
      .collection("favorites")
      .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((venues) {
        for(int i = 0; i < venues.docs.length; i++) {
          if(venues.docs[i].data()['detailedVenue']['id'] == id) {
            FirebaseFirestore.instance.collection("favorites").doc(venues.docs[i].id).delete();
          }
        }
  });
  return true;
}
