import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/EnglishWord.dart';
import '../styles/AppStyles.dart';
import '../value/AppColors.dart';
import '../value/share_key.dart';

class AllWordPage extends StatefulWidget {
  const AllWordPage({super.key, required this.wordsList});
  final List<EnglishWord> wordsList;

  @override
  State<AllWordPage> createState() => _AllWordPageState();
}

class _AllWordPageState extends State<AllWordPage> {
  @override
  Widget build(BuildContext context) {
    String quoteDefault = "\"Think of all the beauty still left around you and be happy.\"";
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        elevation: 0,
        title: Text("All Words", style: AppStyles.h3.copyWith(color: Colors.black87),),
        centerTitle: true,
        leading: InkWell(
          onTap: ()  {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.black87,),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: widget.wordsList.length,
          itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                color: AppColors.colorSecond,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [BoxShadow(color: Colors.black54, offset: Offset(2,4), blurRadius: 2)]),
            child: InkWell(
              onDoubleTap: (){
                setState(() {
                  widget.wordsList[index].isFavorite = !widget.wordsList[index].isFavorite;
                });
              },
              child: ListTile(
                title: Text(widget.wordsList[index].noun!),
                subtitle: Text(widget.wordsList[index].quote != null ? widget.wordsList[index].quote! : quoteDefault),
                leading: Icon(Icons.favorite, color: widget.wordsList[index].isFavorite == true ? Colors.red : Colors.white,),
              ),
            ),
          );
        },
        ),
      ),
    );
  }
}
