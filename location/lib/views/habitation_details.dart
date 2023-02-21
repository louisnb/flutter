import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/models/habitation.dart';
import 'package:location/share/location_style.dart';
import 'package:location/views/resa_location.dart';
import 'package:location/views/share/habitation_features_widget.dart';
import 'package:location/views/share/habitation_option.dart';

import '../share/location_text_style.dart';


class HabitationDetails extends StatefulWidget {
  final Habitation _habitation;
  
  const HabitationDetails(this._habitation, {Key? key}) : super(key: key);

  @override
  State <HabitationDetails> createState() => _HabitationDetailsState();
}

class _HabitationDetailsState extends State<HabitationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._habitation.libelle),
      ),
      body: ListView(
        padding: EdgeInsets.all(4.0),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              'assets/images/locations/${widget._habitation.image}',
              fit: BoxFit.fitWidth,
            ),
          ),
            Container(
              margin: EdgeInsets.all(8.0),
              child: Text(widget._habitation.adresse),
            ),
            HabitationFeaturesWidget(widget._habitation),
            _buildItems(),
            _buildOptionsPayantes(),
            _buildRentButton(),
        ],
      ),
    );
  }
  _buildRentButton() {
    var format = NumberFormat("### €");

    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: LocationStyle.backgroundColorPurple,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              format.format(widget._habitation.prixmois),
            ),
          ),
           Container(
            margin: const EdgeInsets.symmetric(horizontal: 0.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResaLocation(
                            habitation: widget._habitation,
                          )),
                );
              },
              child: const Text('Louer'),
            ),
           ),
        ],
      ),
          );
          
  }
  _buildItems() {
    var width = (MediaQuery.of(context).size.width / 2) - 15;

    return Wrap(
      spacing: 2.0,
      children: Iterable.generate(
        widget._habitation.options.length,
          (i) => Container(
            padding: EdgeInsets.only(left: 15.0),
            margin: EdgeInsets.all(2.0),
            width: width,
            child: ListTile(
              title: Text(widget._habitation.options[i].libelle),
              subtitle: Text(
                              widget._habitation.options[i].description,
                              style: LocationTextStyle.regularTextStyle,
                            ),
            ),
          ),
      ).toList()
    );
  }
  _buildOptionsPayantes() {
    if (widget._habitation.options.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          "Aucune option",
          style: LocationTextStyle.subTitleboldTextStyle,
        ),
      );
    }

    var format = NumberFormat("### €");
    var width = (MediaQuery.of(context).size.width / 3) - 15;
    return Column(children: [

      Wrap(
        spacing: 2.0,
        children: Iterable.generate(
          widget._habitation.optionpayantes.length,
              (i) => Container(
            padding: const EdgeInsets.only(left: 15),
            margin: const EdgeInsets.all(2.0),
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget._habitation.optionpayantes[i].libelle),
                Text(
                  format.format(widget._habitation.optionpayantes[i].prix),
                  style: LocationTextStyle.priceGreyTextStyle,
                ),
              ],
            ),
          ),
        ).toList(),
      ),
    ]);
  }
}
