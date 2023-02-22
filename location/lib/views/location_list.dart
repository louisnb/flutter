import 'package:flutter/material.dart';

import '../models/habitation.dart';
import '../models/location.dart';
import '../services/habitation_service.dart';
import '../services/location_service.dart';
import '../share/location_text_style.dart';

class LocationList extends StatelessWidget {
  final List<Location> _locations = LocationService().getLocations();
  static var routeName = 'location_list';
  final List<Habitation> _habitations = HabitationService().getAllHabitations();
  late Habitation current_habitation;

  LocationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: const BottomNavigationBarWidget(2),
      appBar: AppBar(
        title: Text("Location List"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _locations.length,
          itemBuilder: (context, index) =>
              _buildRow(_locations[index], context),
        ),
      ),
    );
  }

  _buildRow(Location location, BuildContext context) {
    for (var i = 0; i < _habitations.length; i++) {
      if (_habitations[i].id == location.idhabitation) {
        current_habitation = _habitations[i];
        break;
      }
    }
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.home_filled),
            title: Text(current_habitation.libelle),
            subtitle: Text(current_habitation.adresse),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  
                  Text(
                    '${location.dateDebut.day}/${location.dateDebut.month}/${location.dateDebut.year}',
                    style: LocationTextStyle.boldTextStyle,
                  )
                ],
              ),
              Row(
                children: const [
                  CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 38, 0, 255),
                    child: Icon(Icons.arrow_forward),
                  )
                ],
              ),
              Row(
                children: [
                  
                  Text(
                    '${location.dateFin.day}/${location.dateFin.month}/${location.dateFin.year}',
                    style: LocationTextStyle.boldTextStyle,
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}