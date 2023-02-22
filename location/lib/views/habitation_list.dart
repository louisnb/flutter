import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/services/habitation_service.dart';
import 'package:location/views/share/habitation_features_widget.dart';
import 'package:location/views/share/habitation_option.dart';

import '../models/habitation.dart';
import 'habitation_details.dart';


class HabitationList extends StatelessWidget {
  final HabitationService service = HabitationService();
  late List<Habitation> _habitations;
  final bool isHouseList;
HabitationList(this.isHouseList, {Key? key}) : super(key:key)
{
  _habitations = isHouseList ? service.getMaisons() : service.getAppartements();
}

/*
  var _habitations =[
    Habitation(1,"maison.png","Maison1","Adresse1",2,50,500),
    Habitation(2,"appartement.png","Appartement1","Adresse2",3,60,600),
    Habitation(3,"appartement.png","Appartement2","Adresse3",2,70,600),
    Habitation(4,"maison.png","Maison2","Adresse4",5,100,1000),
  ];
*/

  _buildRow(Habitation habitation, BuildContext context){
    return Container(
      margin: const EdgeInsets.all(4.0),
      child : GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HabitationDetails(habitation)),
          );
        },

        child: Column(
          children: [
            SizedBox(
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/images/locations/${habitation.image}',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            _buildDetails(habitation),
          ],
        ),
      ),

    );
  }

  _buildDetails(Habitation habitation){
    var format = NumberFormat("### €");

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex:3,
                child: ListTile(
                  title: Text(habitation.libelle),
                  subtitle: Text(habitation.adresse),
                ),
              ),
              Expanded(
                flex:1,
                child: Text(format.format(habitation.prixmois),
                style: const TextStyle(
                  fontSize: 22,
                  fontFamily: 'Roboto',
                  fontWeight:FontWeight.bold,
                  ),
                ),
              ),
              HabitationFeaturesWidget(habitation)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              HabitationOption(Icons.group,"${habitation.chambres} personnes"),
              HabitationOption(Icons.fit_screen,"${habitation.superficie} m²"),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des ${isHouseList ? 'maisons' : 'appartements'}")
      ),
      body: Center(
        child:  ListView.builder(
          itemCount: _habitations.length,
          itemBuilder: (context,index) => _buildRow(_habitations[index],context),
          itemExtent: 285,
        ),
      ),
    );
  }
}