import 'package:adechallenge/models/venue_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        title: Text("ADEChallenge"),
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
                        "No se encontraron resultados, intente con otra consulta",
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
                                leading: Image.network(provider.venues[index].iconUrl, fit: BoxFit.fill,),
                                title: Text(provider.venues[index].name),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(provider.venues[index].category),
                                    provider.venues[index].distance == -1.0
                                        ? Container()
                                        : Text(provider.venues[index].distance.toString()),
                                    Text(provider.venues[index].address),

                                  ],
                                )));
                      })),
    );
  }
}
