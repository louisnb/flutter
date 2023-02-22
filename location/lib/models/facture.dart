class Facture {
  int id;
  DateTime date;
  String adresse;

  Facture(this.id, this.date, {this.adresse = ""});
  Facture.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = DateTime.parse(json['date']),
        adresse = json['adresse'];
}