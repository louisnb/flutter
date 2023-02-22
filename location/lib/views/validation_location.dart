import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ValidationLocation extends StatefulWidget {
  static const routeName = "ValidationLocation";
  const ValidationLocation({super.key});

  @override
  State<ValidationLocation> createState() => _ValidationLocationState();
}

class _ValidationLocationState extends State<ValidationLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0),
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              Text("Confirmation ok")
            ],
          ),   
      ),
    );
  }
}