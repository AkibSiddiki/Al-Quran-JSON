import 'dart:convert';
import 'dart:io';

void main() {
  // Read JSON data from file 1
  String jsonFile1 = File('quran.json').readAsStringSync();
  List<Map<String, dynamic>> dataFile1 = (jsonDecode(jsonFile1) as List).cast();

  // Read JSON data from file 2
  String jsonFile2 = File('quran_transliteration.json').readAsStringSync();
  List<Map<String, dynamic>> dataFile2 = (jsonDecode(jsonFile2) as List).cast();

  // Combine data from file 1 with transliteration from file 2
  List<Map<String, dynamic>> dataFile3 = combineData(dataFile1, dataFile2);

  // Write combined data to file 3
  File('al_quran.json').writeAsStringSync(jsonEncode(dataFile3));
}

List<Map<String, dynamic>> combineData(List<Map<String, dynamic>> dataFile1,
    List<Map<String, dynamic>> dataFile2) {
  List<Map<String, dynamic>> combinedData = [];

  for (int i = 0; i < dataFile1.length; i++) {
    Map<String, dynamic> itemFile1 = dataFile1[i];
    Map<String, dynamic> itemFile2 = dataFile2[i];

    List<Map<String, dynamic>> newVerses = [];

    for (int j = 0; j < itemFile2['verses'].length; j++) {
      Map<String, dynamic> temp2 = {
        "id": j + 1,
        "text": itemFile1['verses'][j]['text'],
        "transliteration": itemFile2['verses'][j]['transliteration'],
        "translation": itemFile1['verses'][j]['translation']
      };

      newVerses.add(temp2);
    }

    // Combine data
    Map<String, dynamic> combinedItem = {
      "id": itemFile1["id"],
      "name": itemFile1["name"],
      "transliteration": itemFile1["transliteration"],
      "translation": itemFile1["translation"],
      "type": itemFile1["type"],
      "total_verses": itemFile1["total_verses"],
      "verses": newVerses
    };

    combinedData.add(combinedItem);
  }

  return combinedData;
}
