import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studied/styles/AppStyles.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const AppButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(right: 100, top: 15, bottom: 15, left: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [BoxShadow(color: Colors.black54, offset: Offset(1,2), blurRadius: 2)]
        ),
        child: Text(label, style: AppStyles.h5.copyWith(color: Colors.black),),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}
