import 'package:adechallenge/database/queries.dart';
import 'package:adechallenge/models/detailed_venue.dart';
import 'package:adechallenge/models/providers/detailed_venue_provider.dart';
import 'package:adechallenge/utils/navigations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/* This screen shows the venues that are saved as favourite for the current user.*/
class MyFavorites extends StatefulWidget {
  @override
  _MyFavoritesState createState() {
    return new _MyFavoritesState();
  }
}

class _MyFavoritesState extends State<MyFavorites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DetailedVenueProvider>(
      builder: (context, provider, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text("ADEChallenge"),
            ),
            body: provider.loading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : provider.favorites.length == 0
                ? Center(
              child: Text(
                "No se encontraron resultados, intente con otra consulta.",
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            )
                : Container(
              padding: EdgeInsets.all(20.0),
              child: ListView.builder(
                  itemCount: provider.favorites.length,
                  itemBuilder: (context, index) {
                    return Card(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: ListTile(
                          isThreeLine: true,
                          leading: Image.network(provider.favorites[index].iconUrl, fit: BoxFit.fill),
                          title: Text(provider.favorites[index].name),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(provider.favorites[index].category),
                              provider.favorites[index].distance == -1.0
                                  ? Container()
                                  : Text(provider.favorites[index].distance.toString()),
                              provider.favorites[index].address != ""
                                  ? provider.favorites[index].city != ""
                                  ? Text(provider.favorites[index].address +
                                  ", " +
                                  provider.favorites[index].city)
                                  : Text(provider.favorites[index].address)
                                  : Container()
                            ],
                          ),
                          onTap: () {
                            navigateToDetailedVenue(context);
                            provider.getDataFromDatabase(provider.favorites[index]);
                            provider.setFavorite(true);
                          },
                        ));
                  }),
            ));
      },
    );

  }
}
