import 'package:adechallenge/models/venue_provider.dart';
import 'package:adechallenge/utils/navigations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
Screen where the users can search venues. It is built by a background image and a form where we ask the user to
say what they want to search for and where. It redirects to the results view.
 */
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
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 250.0, horizontal: 30.0),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), borderRadius: BorderRadius.circular(30.0)),
            child: _searchForm(),
          ),
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
                decoration: InputDecoration(labelText: "Buscando...", prefixIcon: Icon(Icons.search)),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 8.0),
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) => this.location = value,
                  decoration: InputDecoration(labelText: "En...", prefixIcon: Icon(Icons.place)),
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
          provider.getApiData(name, location);
        },
        child: Text(
          "¡A pasarlo bien!",
        ),
      ),
    );
  }
}
