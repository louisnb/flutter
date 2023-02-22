import 'location.dart';

class LocationsData {
  static final data = [
    {
      "id": 1,
      "idutilisateur": 6,
      "idhabitation": 1,
      "datedebut": "2022-07-01T00:00:00",
      "datefin": "2022-07-04T00:00:00",
      "montanttotal": 710.0,
      "montantverse": 0.0,
      "facture": {
        "id": 1,
        "date": "2022-08-24T00:00:00",
        "adresse": "Adresse",
      },
      "locationOptionpayanteros": [
        {
          "locationId": 1,
          "optionpayanteId": 1,
          "prix": 60.0,
          "optionpayante": {
            "id": 1,
            "libelle": "Ménage",
            "description": "A la fin du séjour"
          }
        },
        {
          "locationId": 1,
          "optionpayanteId": 2,
          "prix": 30.0,
          "optionpayante": {
            "id": 2,
            "libelle": "Drap de lit",
            "description": "Pour l'ensemble des lits"
          }
        },
        {
          "locationId": 1,
          "optionpayanteId": 3,
          "prix": 20.0,
          "optionpayante": {
            "id": 3,
            "libelle": "Linge de maison",
            "description": "Linge de toilette pour la salle de bain"
          }
        }
      ],
      "reglements": [
        {
          "id": 4,
          "locationId": 1,
          "montant": 200.0,
          "dateversement": "2022-07-04T11:01:31",
          "typereglementId": 1,
          "location": null,
          "typereglement": {
            "id": 1,
            "libelle": "Carte Bleue",
            "reglements": [
              null,
              {
                "id": 5,
                "locationId": 1,
                "montant": 200.0,
                "dateversement": "2022-07-04T11:01:52",
                "typereglementId": 1,
                "location": null,
                "typereglement": null
              },
              {
                "id": 6,
                "locationId": 1,
                "montant": 200.0,
                "dateversement": "2022-07-04T11:01:57",
                "typereglementId": 1,
                "location": null,
                "typereglement": null
              }
            ]
          }
        },
        {
          "id": 5,
          "locationId": 1,
          "montant": 200.0,
          "dateversement": "2022-07-04T11:01:52",
          "typereglementId": 1,
          "location": null,
          "typereglement": {
            "id": 1,
            "libelle": "Carte Bleue",
            "reglements": [
              {
                "id": 4,
                "locationId": 1,
                "montant": 200.0,
                "dateversement": "2022-07-04T11:01:31",
                "typereglementId": 1,
                "location": null,
                "typereglement": null
              },
              null,
              {
                "id": 6,
                "locationId": 1,
                "montant": 200.0,
                "dateversement": "2022-07-04T11:01:57",
                "typereglementId": 1,
                "location": null,
                "typereglement": null
              }
            ]
          }
        },
        {
          "id": 6,
          "locationId": 1,
          "montant": 200.0,
          "dateversement": "2022-07-04T11:01:57",
          "typereglementId": 1,
          "location": null,
          "typereglement": {
            "id": 1,
            "libelle": "Carte Bleue",
            "reglements": [
              {
                "id": 4,
                "locationId": 1,
                "montant": 200.0,
                "dateversement": "2022-07-04T11:01:31",
                "typereglementId": 1,
                "location": null,
                "typereglement": null
              },
              {
                "id": 5,
                "locationId": 1,
                "montant": 200.0,
                "dateversement": "2022-07-04T11:01:52",
                "typereglementId": 1,
                "location": null,
                "typereglement": null
              },
              null
            ]
          }
        }
      ],
      "relances": [
        {
          "id": 1,
          "locationId": 1,
          "date": "2022-06-24T16:04:05",
          "motif": "ee",
          "location": null
        }
      ]
    },
    {
      "id": 2,
      "idutilisateur": 6,
      "idhabitation": 2,
      "datedebut": "2022-07-05T00:00:00",
      "datefin": "2022-07-07T00:00:00",
      "montanttotal": 40.0,
      "montantverse": 0.0,
      "facture": null,
      "locationOptionpayanteros": [
        {
          "locationId": 2,
          "optionpayanteId": 1,
          "prix": 40.0,
          "optionpayante": {
            "id": 1,
            "libelle": "Ménage",
            "description": "A la fin du séjour"
          }
        }
      ],
      "reglements": [],
      "relances": []
    }
  ];

  static List<Location> buildList() {
    return data.map( (item) => Location.fromJson(item)).toList();
  }
}