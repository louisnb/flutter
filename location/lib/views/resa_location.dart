import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:location/share/location_style.dart';

import '../models/habitation.dart';
import '../share/location_text_style.dart';

class ResaLocation extends StatefulWidget {
  const ResaLocation({super.key, required this.habitation});

  final Habitation habitation;

  @override
  State<ResaLocation> createState() => _ResaLocationState();
}

class _ResaLocationState extends State<ResaLocation> {
  DateTime dateDebut = DateTime.now();
  DateTime dateFin = DateTime.now();
  String nbPersonnes = '1';
  List<String> listNbPersonnes = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8'
  ];

  var format = NumberFormat("### €");
  List<OptionPayanteCheck> optionPayanteChecks = [];

  double? get prixTotal {
    var total = widget.habitation.prixmois;
    double? addTotal;

    for (var i = 0; i < optionPayanteChecks.length; i++) {
      bool checked = optionPayanteChecks[i].checked;
      double? optionPrix = widget.habitation.optionpayantes[i].prix;

      if (checked == true && optionPrix != null) {
        total = total + optionPrix.toDouble();
      }
    }

    return total;
  }

  Future<Null> _dateTimeRangePicker(BuildContext context) async {
    DateTimeRange? datePicked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 2),
      initialDateRange: DateTimeRange(start: dateDebut, end: dateFin),
      cancelText: 'Annuler',
      confirmText: 'Valider',
      locale: const Locale("fr", "FR"),
    );
    if (datePicked != null) {
      setState(() {
        dateDebut = datePicked.start;
        dateFin = datePicked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadOptionPayantes();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservation"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(4.0),
        children: [
          _buildResume(),
          _buildDates(),
          _buildNbPersonnes(),
          _buildOptionsPayantes(context),
          TotalWidget(prixTotal),
          _buildRentButton()
        ],
      ),
    );
  }

  _loadOptionPayantes() {
    if (optionPayanteChecks.isEmpty) {
      List<OptionPayanteCheck> options = List.generate(
          widget.habitation.optionpayantes.length,
          (index) => OptionPayanteCheck(
              widget.habitation.optionpayantes[index].id,
              widget.habitation.optionpayantes[index].libelle,
              false));

      optionPayanteChecks = options;
    }
  }

  TotalWidget(prixTotal) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(color: LocationStyle.colorPurple, width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(10.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0.0, 0.0, 120.0, 0.0),
            child: Text(
              "TOTAL",
              style: LocationTextStyle.boldTextStyle,
            ),
          ),
          Text(
            format.format(prixTotal),
            style: LocationTextStyle.boldTextStyle,
          )
        ],
      ),
    );
  }

  _buildResume() {
    return ListTile(
      leading: const Icon(Icons.home_filled),
      title: Text(widget.habitation.libelle),
      subtitle: Text(widget.habitation.adresse),
    );
  }

  _buildDates() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => _dateTimeRangePicker(context),
              child: Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsetsDirectional.only(),
                    child: const Icon(Icons.calendar_today_rounded),
                  ),
                  Text(
                    '${dateDebut.day}/${dateDebut.month}/${dateDebut.year}',
                    style: LocationTextStyle.boldTextStyle,
                  )
                ],
              ),
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
            Container(
              padding: const EdgeInsetsDirectional.only(),
              child: const Icon(Icons.calendar_today_rounded),
            ),
            Text(
              '${dateFin.day}/${dateFin.month}/${dateFin.year}',
              style: LocationTextStyle.boldTextStyle,
            )
          ],
        ),
      ],
    );
  }

  _buildNbPersonnes() {
    return Container(
        padding: const EdgeInsets.all(4.0),
        margin: const EdgeInsetsDirectional.only(),
        child: Row(
          children: [
            Text(
              "Nombres de personnes : ",
              style: LocationTextStyle.boldTextStyle,
            ),
            DropdownButton<String>(
              value: nbPersonnes,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 8,
              underline: Container(
                height: 2,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  nbPersonnes = value!;
                });
              },
              items:
                  listNbPersonnes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ));
  }

  _buildOptionsPayantes(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          widget.habitation.optionpayantes.length,
          (index) => CheckboxListTile(
            title: Text(
              "${widget.habitation.optionpayantes[index].libelle} (${format.format(widget.habitation.optionpayantes[index].prix)}) ",
              style: LocationTextStyle.boldTextStyle,
            ),
            subtitle: Text(widget.habitation.optionpayantes[index].description),
            secondary: const Icon(Icons.add_shopping_cart),
            autofocus: false,
            activeColor: Colors.green,
            checkColor: Colors.white,
            value: optionPayanteChecks[index].checked,
            onChanged: (bool? value) {
              if (value != null) {
                value = !optionPayanteChecks[index].checked;
                setState(() {
                  if (value != null) {
                    optionPayanteChecks[index].checked = value;
                  }
                });
              }
            },
          ), //CheckboxListTile
        ),
      ),
    );
  }

  _buildRentButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(padding: EdgeInsets.only(top: 8.0)),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ResaLocation(
                        habitation: widget.habitation,
                      )),
            );
          },
          child: Container(
              padding: const EdgeInsets.all(10.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: LocationStyle.colorPurple,
                  border:
                      Border.all(color: LocationStyle.colorPurple, width: 2.0),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Louer",
                    style: LocationTextStyle.regularWhiteTextStyle,
                  ),
                ],
              )),
        )
      ],
    );
  }
}
