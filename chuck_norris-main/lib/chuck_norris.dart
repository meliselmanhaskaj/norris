import "dart:convert";
import "models/pilloladivita.dart";
import "package:http/http.dart" as http;
import "package:dotenv/dotenv.dart"; //dart pub add dotenv , dart pub global activate dotenv
import "dart:io";

const url1Str = "https://api.chucknorris.io/jokes/random?category";
final url1Uri = Uri.parse(url1Str);
const url2Str = "https://api.chucknorris.io/jokes/search?query";
final url2Uri = Uri.parse(url2Str);

//citazioni per categoria
Future<PilloladiVita> getCategoriaPilloladiVita(String categoria) async {
  final url1 = url1Uri.replace(queryParameters: {"category": categoria});
  final res = await http.get(url1);
  final data = res.body;
  return PilloladiVita.fromJson(data);
}

//citazioni per categoria in .env
Future<PilloladiVita> getEnvPilloladiVita() async {
  final env = DotEnv()..load();
  final categoria1 = env['CATEGORY'];
  final urlSingle = url1Uri.replace(queryParameters: {"category": categoria1});
  final res = await http.get(urlSingle);
  final data = res.body;
  return PilloladiVita.fromJson(data);
}

//citazioni filtrate per parola
Future<String> getPilloladiVitaFiltrata() async {
  print("Quale stringa deve contenere la citazione?");
  String? a = stdin.readLineSync();
  final url2 = url2Uri.replace(queryParameters: {"query": a});

  //API call
  final res = await http.get(url2);

  //Mappa il risultato nella variabile data per poter accedere alle coppe chiave-valore
  final Map<String, dynamic> data = json.decode(res.body);
  final resArray =
      data['result'] as List; //perchè non List<Map<String, dynamic>>
  final array = resArray.map((e) => PilloladiVita.fromMap(e));
  final lista = array.toList();

  //Crea file
  final file = File('$a.txt');
  file.create();
  //scrivi lista di citazioni resituite
  await file.writeAsString(lista.toString());
  return "Risultati trovati: ${data['total']} - Salvati nel file $a.txt ";
}
