


import 'package:hive/hive.dart';
part 'EnglishWord.g.dart';
@HiveType(typeId: 0)
class EnglishWord extends HiveObject{
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? noun;
  @HiveField(2)
  String? quote;
  @HiveField(3)
  bool isFavorite = false;
  EnglishWord({this.id, this.noun, this.quote, this.isFavorite = false});

}