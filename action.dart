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
  List<String> surahNamesBangla = [
    "আল-ফাতিহা",
    "আল-বাক্বারা",
    "আল-ইউসুফ",
    "আন-নিসা",
    "আল-মাইদা",
    "আল-আনআম",
    "আল-আরাফ",
    "আল-আনফাল",
    "আত-তাওবা",
    "ইউনুস",
    "হুদ",
    "ইউসুফ",
    "আর-রাদ",
    "ইবরাহীম",
    "আল-হিজর",
    "আন-নাহল",
    "আল-ইসরা",
    "আল-কাহফ",
    "মারিয়াম",
    "তাহা",
    "আল-আম্বিয়া",
    "আল-হাজ্জ",
    "আল-মুমিনুন",
    "আন-নূর",
    "আল-ফুরকান",
    "আশ-শুআরা",
    "আন-নামল",
    "আল-আংকাবূত",
    "আর-রুম",
    "লুকমান",
    "আস-সজদা",
    "আল-আহজাব",
    "সবা",
    "ফাতির",
    "ইয়াসিন",
    "আস-সাফফাত",
    "সাদ",
    "আয়াত-আল-কুরসি",
    "গফির",
    "ফুসিলত",
    "ফুসিলত-ফুসিলত",
    "আশ-শুরা",
    "আয়াত-আল-কুরসি",
    "আদ-দুখান",
    "আল-জাসিয়া",
    "আল-আহকাফ-",
    "মুহাম্মদ",
    "আল-ফাতহ",
    "আল-হুজুরাত",
    "আয়াত-আল-কুরসি",
    "আদ-ধারিয়াত",
    "আত-তুর",
    "আন-নাজম",
    "আল-কামিল",
    "আর-রহমান",
    "আল-ওয়াকিয়া",
    "আল-হাদীস",
    "আল-মুজাদিলা",
    "আল-হাশর",
    "আল-মুম্তাহিনা",
    "আস-সাফ",
    "আল-জুমুআ",
    "আল-মুনাফিকুন",
    "আত-তাগাবুন",
    "আত-তালাক",
    "আত-তাহরীম",
    "আল-মুলক",
    "আল-কলাম",
    "আল-হাক্কা",
    "আল-মাআরিজ",
    "নূহ",
    "আল-জিন",
    "আল-মুজাম্মিল",
    "আল-মুদাত্তির",
    "আল-কিয়ামা",
    "আল-ইনসান",
    "আল-মুরসালাত",
    "আন-নাবা",
    "আন-নাজিয়াত",
    "আবাসা",
    "আত-তাকযীর",
    "আল-ইনফিতার",
    "আল-মুতাফ়ফির",
    "আল-ইনশিকাক",
    "আল-বুরুজ",
    "আত-তারিক",
    "আল-আলা",
    "আল-গাশিয়া",
    "আল-ফজর",
    "আল-বালাদ",
    "আশ-শমস",
    "আল-লাইল",
    "আয়াত-আল-কুরসি",
    "আশ-শরহ",
    "আত-তিন",
    "আল-আলাক",
    "আল-কদর",
    "আল-বাইয়্যিনা",
    "আল-যিলয়াল",
    "আল-আদিয়াত",
    "আল-কারিয়া",
    "আত-তাকাসুর",
    "আল-আসর",
    "আল-হুমায়ুন",
    "আল-ফিল",
    "কুরাইস",
    "আল-মাউন",
    "আল-কাউসার",
    "আল-কাফিরুন",
    "আন-নাসর",
    "আল-লাহাব",
    "আল-ইখলাস",
    "আল-ফালাক",
    "আন-নাস",
  ];

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
      "transliteration": surahNamesBangla[i],
      "translation": itemFile1["translation"],
      "type": itemFile1["type"],
      "total_verses": itemFile1["total_verses"],
      "verses": newVerses
    };

    combinedData.add(combinedItem);
  }

  return combinedData;
}
