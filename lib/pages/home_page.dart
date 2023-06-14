  import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studied/hive/hive_favorite.dart';
import 'package:studied/models/EnglishWord.dart';
import 'package:studied/packages/quote.dart';
import 'package:studied/pages/all_word_page.dart';
import 'package:studied/pages/favorite_page.dart';
import 'package:studied/pages/your_control_page.dart';
import 'package:studied/styles/AppStyles.dart';
import 'package:studied/value/AppColors.dart';
import 'package:studied/value/share_key.dart';
import 'package:studied/wigets/app_button.dart';

import '../packages/qoute_model.dart';

class HomePage extends StatefulWidget {
    const HomePage({super.key});
    @override
    State<HomePage> createState() => _HomePageState();
  }
  
  class _HomePageState extends State<HomePage>  {

  List<EnglishWord> englishdb = [];
  int _quoteCounter = 5;
  int _currentIndex = 0;
  late PageController _pageController ;
  late String quoteTitle ;
  List<EnglishWord> listWord = [];
  List<int> fixedRandom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];

    Random random = new Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglishList() async{

    englishdb = await Boxes.getListFavorite();
    SharedPreferences shaf = await SharedPreferences.getInstance();
    _quoteCounter = shaf.getInt(ShareKey.COUNTER) ?? 5;
    List<String> newList = [];
    List<int> rans = fixedRandom(len: _quoteCounter, max: nouns.length);
    rans.forEach((index) {
      newList.add(nouns[index]);
    });
    setState(() {
      listWord = newList.map((e) => getQuote(e)).toList();
    });
  }

  EnglishWord getQuote(String noun){
    Quote? quote;
    quote = Quotes().getByWord(noun);
    return EnglishWord(
      noun: noun,
      quote: quote?.content,
      id: quote?.id,
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
  void initState() {
    // TODO: implement initState
      _pageController = PageController(viewportFraction: 0.9);
      super.initState();
      getEnglishList();
      setState(() {
        quoteTitle = Quotes().getRandom().content!;
      });
    }

    @override
    Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.colorPrimary,
          appBar: AppBar(
            backgroundColor: AppColors.colorPrimary,
            elevation: 0,
            title: Text("English today", style: AppStyles.h3.copyWith(color: Colors.black87),),
            centerTitle: true,
            leading: InkWell(
              onTap: (){
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Icon(Icons.menu, color: Colors.black87,),
            ),
          ),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                  height: size.height * 1/10,
                  alignment: Alignment.centerLeft,
                  child: Text("\"${quoteTitle}\"", style: AppStyles.h5.copyWith(color: Colors.black, fontSize: 18),)),
              Container(

                height: size.height * 2/3,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: listWord.length > 5 ? 6 : listWord.length,
                    itemBuilder: (context, index){
                        String firstLetter = listWord[index].noun != null ? listWord[index].noun! : '';
                        firstLetter = firstLetter.substring(0, 1);
                        String leftLetter  = listWord[index].noun != null ? listWord[index].noun! : '';
                        leftLetter = leftLetter.substring(1);

                        String quoteDefault = "\"Think of all the beauty still left around you and be happy.\"";
                        String quote = listWord[index].quote != null ? "\"" + listWord[index].quote! + "\"" : quoteDefault;

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Material(
                          borderRadius: BorderRadius.all(Radius.circular(20),),
                          color: AppColors.colorSecond,
                          elevation: 2,
                          child: InkWell(
                            onDoubleTap: (){
                              setState(() {
                                // deleteAll();
                                // print(englishdb.length);
                                  listWord[index].isFavorite = !listWord[index].isFavorite;
                                  if(listWord[index].isFavorite == true){
                                    Boxes.addFavorite(listWord[index]);
                                  }else{
                                    Boxes.deleteFavorite(listWord[index]);
                                  }
                                print(listWord[index].noun);
                                  print(listWord[index].quote);
                              });
                            },
                            borderRadius: BorderRadius.all(Radius.circular(20),),
                            splashColor: Colors.black12,

                            child: Container(
                              padding: const EdgeInsets.all(15),
                              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),

                              child: index >= 5 ? InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => AllWordPage(wordsList: listWord,)));
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      child: Text("Show more...", style: AppStyles.h3, textAlign: TextAlign.center,)),
                              ) : Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                      listWord[index].isFavorite == true ? Container(
                                        child: Image.asset("assets/images/like.png", color: Colors.red,),
                                        alignment: Alignment.centerRight,) :Container(
                                        child: Image.asset("assets/images/like.png", color: Colors.white,),
                                        alignment: Alignment.centerRight,)
                                    ,
                                    RichText(
                                        text: TextSpan(
                                          text: firstLetter,
                                          children: [
                                            TextSpan(text: leftLetter, style: AppStyles.h2.copyWith(fontSize: 40, ))
                                          ],
                                          style: AppStyles.h1.copyWith(fontSize: 80,shadows: [
                                            BoxShadow(color: Colors.black26, offset: Offset(3, 6), blurRadius:6)
                                          ], fontWeight: FontWeight.bold)
                                        ),
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(10),
                                        child: AutoSizeText(quote,
                                          style: AppStyles.h4.copyWith(color: Colors.black54), maxFontSize: 25,)
                                    ),
                                  ],
                                ),
                              ),

                            ),
                          ),
                        ),
                      );
                    }),
              ),

              // indicator
              _currentIndex >= 5 ?
              Container(
              //   padding: EdgeInsets.symmetric(horizontal: 30),
              //   alignment: Alignment.centerLeft,
              // child: buildShowMoreBtn()
              ):

              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                height: 12,
                child:
                ListView.builder(
                    scrollDirection: Axis.horizontal,
                    reverse: false,
                    itemCount: 5, itemBuilder: (context, index){
                  return buildIndicator(index == _currentIndex, size);
                }),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
           setState(() {
             getEnglishList();
             quoteTitle = Quotes().getRandom().content!;
             // _currentIndex = 0;
           });
          },
          backgroundColor: AppColors.colorSecond,
          child: Icon(Icons.recycling_outlined, color: Colors.white,),
        ),
        drawer: Drawer(
          child: Container(
            color: AppColors.colorSecond,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 70, left: 20),
                  child: Text("Your mind", style: AppStyles.h3.copyWith(color: Colors.black),),
                ),
                
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 10),
                  child: AppButton(label: "Favorites", onTap: (){
                    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage());
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritePage()));
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 10),
                  child: AppButton(label: "Your control", onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => YourControlPage()));
                  }),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget buildIndicator(bool isActive, Size size){
      return AnimatedContainer(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: isActive ? size.width * 1/4 : 30,
        height: 20,
        decoration: BoxDecoration(
          color: isActive ? AppColors.colorSecond : Colors.white38,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(color: Colors.black26, offset: Offset(2,3), blurRadius: 3)
          ]), duration: Duration(milliseconds: 300),
        curve: Curves.easeInQuart,
      );
    }

    Widget buildShowMoreBtn(){
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AllWordPage(wordsList: listWord)));
          }, child: Text("Show more", style: AppStyles.h5),
        ),
        decoration: BoxDecoration(
            color: AppColors.colorSecond,
            borderRadius: BorderRadius.all(Radius.circular(20),
            ),
            boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(2,4), blurRadius: 1)]
        ),
      );
    }

    @override
  void dispose() {
    // TODO: implement dispose
      Hive.box('my_box').close();
      super.dispose();

  }
  }
  