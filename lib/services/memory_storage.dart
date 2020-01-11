import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class MemoryStorage {
  MemoryStorage();
  File jsonFile;
  Directory dir;
  String fileName = "myJSONFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;

  getLocalPath() async {
    var lista = [];
    await getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      lista.add(jsonFile);
      fileExists = jsonFile.existsSync();
      lista.add(dir);
      lista.add(fileExists);
      if (fileExists) fileContent = jsonDecode(jsonFile.readAsStringSync());
      lista.add(fileContent);
    });

    return lista;
  }

  void createFile(
      Map<String, dynamic> content, Directory dir, String fileName) {
    print("Creating file!");
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(jsonEncode(content));
  }

  void writeToFile(Map<String, dynamic> content, Directory dirr, String fileNom,
      File jsonFile1, bool fileExist1) {
    print("Writing to file!");
    if (fileExist1) {
      print("File exists");
      Map<String, dynamic> jsonFileContent =
          json.decode(jsonFile1.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile1.writeAsStringSync(jsonEncode(jsonFileContent));
    } else {
      print("File does not exist!");
      createFile(content, dirr, fileNom);
    }
    fileContent = jsonDecode(jsonFile1.readAsStringSync());
    print(fileContent);
  }
}
