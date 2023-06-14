
import 'package:flutter/material.dart';
import 'package:studied/pages/home_page.dart';
import 'package:studied/styles/AppStyles.dart';
import 'package:studied/value/AppColors.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorSecond,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Expanded(child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "Welcome to",
                style: AppStyles.h3,
              ),
            )),
            Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("English",
                          style: AppStyles.h2.copyWith(color:Colors.black45, fontWeight: FontWeight.bold, fontSize: 71)),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text("Qoutes\"",
                            style: AppStyles.h4,
                          textAlign: TextAlign.right,),
                        )
                      ],
                    ),
                  ),
                )
            ),
            Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  child: RawMaterialButton(
                    shape: CircleBorder(),
                    fillColor: Colors.white,
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(Icons.arrow_forward_ios_rounded, size: 60,),
                    ),
                  )
                )
            )
          ],
        ),
      ),
    );
  }
}
