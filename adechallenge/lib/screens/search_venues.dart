import 'package:adechallenge/models/providers/detailed_venue_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/providers/venue_provider.dart';
import 'package:adechallenge/utils/navigations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


/// Screen where the users can search venues. It is built by a background image and a form where we ask the user to
/// say what they want to search for and where. It redirects to the results view.
class SearchVenues extends StatefulWidget {
  @override
  _SearchVenuesState createState() {
    return new _SearchVenuesState();
  }
}

class _SearchVenuesState extends State<SearchVenues> {
  late String name;
  late String location;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/city-background.jpg'),
                  fit: BoxFit.fill,
                  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop))),
          child: Column(
            children: [
              _myFavorites(),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / 4, horizontal: 30.0),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), borderRadius: BorderRadius.circular(30.0)),
                child: _searchForm(),
              ),
              _logOut()
            ],
          )
        ),
      ),
    );
  }

  Widget _searchForm() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: TextFormField(
                textCapitalization: TextCapitalization.words,
                onChanged: (value) => this.name = value,
                decoration: InputDecoration(labelText: "Looking for...", prefixIcon: Icon(Icons.search)),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 8.0),
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) => this.location = value,
                  decoration: InputDecoration(labelText: "At...", prefixIcon: Icon(Icons.place)),
                )),
            _button()
          ],
        ));
  }

  Widget _button() {
    var provider = Provider.of<VenueProvider>(context);
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            primary: Theme.of(context).primaryColor,
            elevation: 3),
        onPressed: () {
          navigateToDisplayVenues(context);
          provider.getVenuesFromAPI(name, location);
        },
        child: Text(
          "Let's find out!",
        ),
      ),
    );
  }

  Widget _myFavorites() {
    var provider = Provider.of<DetailedVenueProvider>(context);
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 24),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            primary: Theme.of(context).primaryColor,
            elevation: 3),
        onPressed: () {
          navigateToMyFavorites(context);
          provider.getFavoriteListFromDatabase();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("My favorites "),
            Icon(Icons.star, color: Colors.yellow.shade800)
          ],
        )
      ),
    );
  }

  Widget _logOut() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              primary: Theme.of(context).primaryColor,
              elevation: 3),
          onPressed: () async{
            SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.remove("loggedUser");
            navigationLogOut(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Logout "),
              Icon(Icons.power_settings_new, color: Colors.white)
            ],
          )
      ),
    );
  }
}
