import 'package:chuck_norris/chuck_norris.dart' as chuck_norris;
import "dart:io";
import 'package:chuck_norris/services/categorie.dart';

void main(List<String> arguments) async {
  print(
      "Scegli: \n1. pillola da categoria scelta \n2. pillola nel file .env\n3. Filtra le pillole\n");
  print("Inserisci numero corrispondente");
  //variabile di scelta che verrà usata per selezionare opzione menu
  var scelta = stdin.readLineSync();
//menu
  switch (scelta) {
    //selezionata pillola da categoria scelta
    case "1":
      final categorie = await getCategories();
      for (var i = 0; i < categorie.length; i++) {
        print("$i) ${categorie[i]}");
      }
      //l'utente inserisce un numero (indice)
      print("categoria : ");
      final categoriaI = stdin.readLineSync();
      //prendi il valore dell'array all'indice corrispondente
      final categoria = categorie[int.parse(categoriaI!)];
      print("categoria selezionata: $categoria");
      final pillola = await chuck_norris.getCategoriaPilloladiVita(categoria);
      print(pillola);
      break;
    // selezionata pillola nel file
    case "2":
      final pillola = await chuck_norris.getEnvPilloladiVita();
      print(pillola);
      break;
    // selezionata filtra le pillole
    case "3":
      final ris = await chuck_norris.getPilloladiVitaFiltrata();
      print(ris);
      break;
    // selezionata opzione non presente come opzione
    default:
      print(
          "Errore - Il numero Inserito non corrisponde con quelli selezionabili");
  }
}
