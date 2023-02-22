import '../models/facture.dart';

import '../models/locations_data.dart';
import '../models/location.dart';

class LocationService {
  List<Location> _locations = [];

  LocationService() {
    _locations = LocationsData.buildList();
  }

  List<Location> getLocations() {
    return _locations;
  }
}