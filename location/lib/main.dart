import 'dart:html';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:location/models/habitation.dart';
import 'package:intl/intl.dart';
import 'package:location/models/location.dart';
import 'package:location/models/type_habitat.dart';
import 'package:location/services/habitation_service.dart';
import 'package:location/share/location_style.dart';
import 'package:location/share/location_text_style.dart';
import 'package:location/views/habitation_list.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:location/views/location_list.dart';
import 'package:location/views/login_page.dart';
import 'package:location/views/profil.dart';
import 'package:location/views/validation_location.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Locations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Mes locations'),
      routes: {
        Profil.routeName: (context) => const Profil(),
        LoginPage.routeName: (context) => const LoginPage(),
        LocationList.routeName: (context) => LocationList(),
        ValidationLocation.routeName: (context) => const ValidationLocation(),
      },
     localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [Locale('en', 'US'), Locale('fr', 'FR')],
    );
  }
}

class MyHomePage extends StatelessWidget {
  final HabitationService service = HabitationService();
  final String title;
  late List<TypeHabitat> _typehabitats;
  late List<Habitation> _habitations;
  MyHomePage({required this.title, Key? key})
      : super(key: key) {
    _habitations = service.getHabitationTop10();
    _typehabitats = service.getTypeHabitats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            _buildTypeHabitat(context),
            SizedBox(height: 20),
            _buildDerniereLocation(context),
            
          ],
        ),
      ),
      bottomNavigationBar: BotttomNavigationBarWidget(0),
      );   
  }
  _buildTypeHabitat(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.0),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
        _typehabitats.length,
        (index) => _buildHabitat(context, _typehabitats[index])
        ),
      ),
    );
  }
  _buildHabitat(BuildContext context, TypeHabitat typeHabitat) {
    var icon = Icons.house;
    switch (typeHabitat.id) {
      // case 1: House
      case 2:
        icon = Icons.apartment;
        break;
      default:
        icon = Icons.home;
    }
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: LocationStyle.backgroundColorPurple,
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HabitationList(typeHabitat.id == 1),
              ));
          },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white70,
            ),
            SizedBox(width: 5),
            Text(
              typeHabitat.libelle,
              style: LocationTextStyle.regularWhiteTextStyle,
            )
          ],
        ),
        ),
      ),
      );
  }
  _buildDerniereLocation(BuildContext context) {
    return Container(
      height: 240,
      child: ListView.builder(
          itemCount: _habitations.length,
          itemExtent: 220,
          itemBuilder: (context, index) =>
              _buildRow(_habitations[index], context),
          scrollDirection: Axis.horizontal,
      ),
    );
  }
  _buildRow(Habitation habitation, BuildContext context) {
    var format = NumberFormat("### €");

    return Container(
      width: 240,
      margin: EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              'assets/images/locations/${habitation.image}',
              fit: BoxFit.fitWidth,
            ),
          ),
          Text(
              habitation.libelle,
              style: LocationTextStyle.regularTextStyle,
          ),
          Row(
            children: [
              Icon(Icons.location_on_outlined),
              Text(
                  habitation.adresse,
                  style: LocationTextStyle.regularTextStyle,
              ),
            ],
          ),
          Text(
            format.format(habitation.prixmois),
            style: LocationTextStyle.boldTextStyle,
          ),
        ],
      ),
    );
  } 
}

class BotttomNavigationBarWidget extends StatelessWidget {
    final int indexSelected;
    const BotttomNavigationBarWidget(this.indexSelected, {Key? key}
    ) : super(key: key);
        

    @override
    Widget build(BuildContext context) {
      bool isUserNotConnected = true;

      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: indexSelected,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          BottomNavigationBarItem(
            icon: isUserNotConnected
                ? const Icon(Icons.shopping_cart_checkout_outlined)
                : BadgeWidget(
                  value: 0,
                  top: 0,
                  right: 0,
                  child: const Icon(Icons.shopping_cart),
                ),
            label: 'locations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        onTap: (index) {
          String page = '/';
          switch (index) {
            case 2:
              page = LocationList.routeName;
              break;
            case 3:
              page = Profil.routeName;
              break;
          }
          Navigator.pushNamedAndRemoveUntil(
            context,
            page,
            (route) => false,
            );
        },
      );
    }
  }

  class BadgeWidget extends StatelessWidget {
    final double top;
    final double right;
    final Widget child;
    final int value;
    final Color? color;

    BadgeWidget({
      required this.child,
      required this.value,
      required this.top,
      required this.right,
      this.color,
    });

    @override
    Widget build(BuildContext context) {
      return Stack(
        alignment: Alignment.center,
        children: [
          child,
          value == 0
              ? Container()
              : Positioned(
                right: this.right,
                top: this.top,
                child: Container(
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: this.color != null ? this.color : Colors.red
                  ),
                  child: Text(
                    value.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                )
              )
        ],
      );
    }
  }






