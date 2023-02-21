import 'package:flutter/material.dart';
import 'package:location/models/habitation.dart';
import 'package:location/views/share/habitation_option.dart';

class HabitationFeaturesWidget extends StatelessWidget {
  final Habitation _habitation;

  const HabitationFeaturesWidget(this._habitation, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        HabitationOption(Icons.group, "${_habitation.nbpersonnes} personnes"),
        HabitationOption(Icons.bed, "${_habitation.chambres} chambres"),
        HabitationOption(Icons.fit_screen, "${_habitation.superficie} m²"),
      ],
    );
  }
}
