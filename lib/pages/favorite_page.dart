import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studied/hive/hive_favorite.dart';
import 'package:studied/styles/AppStyles.dart';
import 'package:studied/value/AppColors.dart';

import '../models/EnglishWord.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<EnglishWord> listFavorite = [];
  List<EnglishWord> listWord = [];
  @override

  String quoteDefault = "\"Think of all the beauty still left around you and be happy.\"";


  // void getListFavorite() {
  //   final listFavorite = Boxes.getListFavorite();
  //   print(listFavorite.length);
  // }

  void initState() {
    // TODO: implement initState
    super.initState();
    // getListFavorite();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.colorPrimary,
        appBar: AppBar(
          backgroundColor: AppColors.colorPrimary,
          elevation: 0,
          title: Text("Favorite Words", style: AppStyles.h3.copyWith(color: Colors.black87),),
          centerTitle: true,
          leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.black87,),
          ),
        ),
        body: Container(
          child:
              ValueListenableBuilder<Box<EnglishWord>>(
                valueListenable: Boxes.getFavorite().listenable(),
                builder: (context, box, _){
                      final ListenglishWord = box.values.toList().cast<EnglishWord>();
                      return buildListView(ListenglishWord);
                },
              )

        ),
    );
  }

  Widget buildListView(List<EnglishWord> englishWord){
   return Container(
      child:
      englishWord.length == 0 ? Text("No favorite word have added!") :
      ListView.builder(
        itemCount: englishWord.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                color: AppColors.colorSecond,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [BoxShadow(color: Colors.black54, offset: Offset(2,4), blurRadius: 2)]),
            child: InkWell(
              onDoubleTap: (){
                print(englishWord[index].quote);
                print(englishWord[index].key);
                setState(() {
                  Boxes.deleteFavorite(englishWord[index]);
                });
              },
              child: ListTile(
                title: Text(englishWord[index]?.noun ?? ''),
                subtitle: Text(englishWord[index].quote != null ? englishWord[index].quote! : quoteDefault),
                leading: Icon(Icons.favorite, color: englishWord[index].isFavorite == true ? Colors.red : Colors.white,),
              ),
            ),
          );
        },
      ),
    );
  }
}
