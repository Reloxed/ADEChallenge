import 'package:adechallenge/models/providers/detailed_venue_provider.dart';

import '../models/providers/venue_provider.dart';
import 'package:adechallenge/utils/navigations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// This screen displays the venues found on the general search from the FourSquare API.
class DisplayVenues extends StatefulWidget {
  @override
  _DisplayVenuesState createState() {
    return new _DisplayVenuesState();
  }
}

class _DisplayVenuesState extends State<DisplayVenues> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<VenueProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Venues found"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: provider.loading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : provider.venues.length == 0
                ? Center(
                    child: Text(
                      "Results not found, try with another search.",
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    itemCount: provider.venues.length,
                    itemBuilder: (context, index) {
                      return Card(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          child: ListTile(
                            isThreeLine: true,
                            leading: Image.network(provider.venues[index].iconUrl, fit: BoxFit.fill),
                            title: Text(provider.venues[index].name),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(provider.venues[index].category),
                                provider.venues[index].distance == -1.0
                                    ? Container()
                                    : Text(provider.venues[index].distance.toString()),
                                provider.venues[index].address != ""
                                    ? provider.venues[index].city != "" ?
                                    Text(provider.venues[index].address + ", " + provider.venues[index].city)
                                    : Text(provider.venues[index].address) : Container()
                              ],
                            ),
                            onTap: () async {
                              var provider2 = Provider.of<DetailedVenueProvider>(context, listen: false);
                              navigateToDetailedVenue(context);
                              await provider2.getDetailedVenueFromAPI(provider.venues[index].id);
                              await provider2.getIsFavoriteFromDatabase(provider.venues[index].id);
                            },
                          ));
                    }),
      ),
      floatingActionButton: provider.venues.length == 0
          ? Container()
      // This button opens the map where the venues found are shown.
          : FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () => {navigateToMapVenues(context), provider.getAverageCoor(), provider.getMarkers(context)},
              child: Icon(Icons.map),
            ),
    );
  }
}
