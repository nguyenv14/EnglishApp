import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studied/models/EnglishWord.dart';

class Boxes{
  static Box<EnglishWord> getFavorite() => Hive.box<EnglishWord>("favorite");

  static Future addFavorite(EnglishWord englishWord) async {
      final box = getFavorite();
      box.add(englishWord);
  }

  static Future<List<EnglishWord>> getListFavorite() async {
    final box = getFavorite();
    List<EnglishWord> list = box.values.toList().cast<EnglishWord>();
    return list;
  }
  static void deleteFavorite(EnglishWord englishWord){
    // englishWord.delete();
    final box = getFavorite();
    box.delete(englishWord.key);
  }
}

// void saveList(List<EnglishWord> list) async {
//   var box = await Hive.openBox('my_box');
//   await box.put('favorite_list', list);
//   await box.close();
// }
//
// Future<List<EnglishWord>> getList() async {
//   var box = await Hive.openBox('my_box');
//   List<EnglishWord> list = box.get('favorite_list', defaultValue: []);
//   await box.close();
//   return list;
// }
//
// Future<List<EnglishWord>> getList1() async {
//   var box = await Hive.openBox('my_box');
//   List<dynamic> dynamicList = box.get('favorite_list', defaultValue: []);
//   await box.close();
//
//   List<EnglishWord> list = dynamicList.cast<EnglishWord>();
//   return list;
// }
//
// void deleteList(EnglishWord englishWord) async{
//   var box = await Hive.openBox('my_box');
//   List<dynamic> dynamicList = box.get('favorite_list', defaultValue: []);
//
//   List<EnglishWord> list = dynamicList.cast<EnglishWord>();
//   list.remove(englishWord);
//   saveList(list);
// }
//
// void deleteAll() async{
//   // var box = await Hive.openBox('my_box');
//   // List<dynamic> dynamicList = box.get('favorite_list', defaultValue: []);
//   // List<EnglishWord> list = dynamicList.cast<EnglishWord>();
//   // list.removeRange(0, list.length-1);
//   saveList([]);
// }

void saveFavoriteWord(EnglishWord englishWord) async{
  var box = await Hive.openBox('my_box');
  List<dynamic> dynamicList = box.get('favorite_list', defaultValue: []);

  List<EnglishWord> list = dynamicList.cast<EnglishWord>();
  list.add(englishWord);
  await box.put('favorite_list', list);
  await box.close();
}

// void searchWord(String noun){
//
// }