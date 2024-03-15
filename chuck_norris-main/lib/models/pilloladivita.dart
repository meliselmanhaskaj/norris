import 'dart:convert';

class PilloladiVita {
  String text, id, createdAt;
  PilloladiVita(
      {required this.text, required this.id, required this.createdAt});
//factory (tipo speciale di costruttore) che deserializza (trasforma) dati json in oggetti dart
  factory PilloladiVita.fromJson(String jsonString) {
    final Map<String, dynamic> data = json.decode(jsonString);
    return PilloladiVita.fromMap(data);
  }
//factory (tipo speciale di costruttore) che ti consente di convertire una mappa di dati in un oggetto PilloladiVita
  factory PilloladiVita.fromMap(Map<String, dynamic> map) {
    final citazione = PilloladiVita(
        text: map['value'], id: map['id'], createdAt: map['created_at']);
    return citazione;
  }
//l'override serve per indicare che un metodo sta sovrascrivendo un metodo della classe genitore (superclasse)
  @override
  String toString() {
    return "Citazione: $text - Id: $id - Data: $createdAt";
  }
}
