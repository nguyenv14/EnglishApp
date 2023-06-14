import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studied/styles/AppStyles.dart';
import 'package:studied/value/AppColors.dart';
import 'package:studied/value/share_key.dart';

class YourControlPage extends StatefulWidget {
  const YourControlPage({super.key});

  @override
  State<YourControlPage> createState() => _YourControlPageState();
}

class _YourControlPageState extends State<YourControlPage> {
  double sliderValue = 5;
  late SharedPreferences shaf;
  @override
  void initState()  {

    // TODO: implement initState
    super.initState();
    initValue();
  }

  void initValue() async {
    shaf = await SharedPreferences.getInstance();
    int valCounter = shaf.getInt(ShareKey.COUNTER) ?? 5;
    setState(() {
      sliderValue = valCounter.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        elevation: 0,
        title: Text("Your control", style: AppStyles.h3.copyWith(color: Colors.black87),),
        centerTitle: true,
        leading: InkWell(
          onTap: () async {
            SharedPreferences  sharedPreferences = await SharedPreferences.getInstance();
            await sharedPreferences.setInt(ShareKey.COUNTER, sliderValue.toInt());
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Colors.black87,),
        ),
      ),
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Text("How much a number word at once", style: AppStyles.h5.copyWith(fontSize: 20, color: Colors.black54), textAlign: TextAlign.center,),
            Spacer(),
            Text("${sliderValue.toInt()}", style: AppStyles.h1.copyWith(fontSize: 170, color: AppColors.colorSecond, fontWeight: FontWeight.bold),),
            Spacer(),
            Slider(
                activeColor: AppColors.colorSecond,
                value: sliderValue,
                min: 5,
                max: 100,
                divisions: 95,
                onChanged: (value){
              setState(() {
                sliderValue = value;
              });
            }),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Text("Slide to set", style: AppStyles.h5.copyWith(color: Colors.black54),),
            ),
            Spacer(),
            Spacer(),
            Spacer(),

          ],

        ),
      ),
    );
  }
}
