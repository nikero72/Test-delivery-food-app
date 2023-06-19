import 'package:flutter/material.dart';

class AppColors {
  Color white = const Color.fromRGBO(255, 255, 255, 1);
  Color blue = const Color.fromRGBO(51, 100, 224, 1);
  Color lightGrey = const Color.fromRGBO(165, 169, 178, 1);
  Color black = const Color.fromRGBO(0, 0, 0, 1);
  Color light = const Color.fromRGBO(248, 247, 245, 1);
  Color transparentBlack = const Color.fromRGBO(0, 0, 0, 0.4);
  Color lightBlack = const Color.fromRGBO(0, 0, 0, 0.65);
  Color mediumBlack = const Color.fromRGBO(0, 0, 0, 0.5);
}

class AppTextStyle {
  TextStyle n510 = const TextStyle(
      fontFamily: '.SF UI Display',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 10
  );

  TextStyle n520 = TextStyle(
      fontFamily: '.SF UI Display',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: AppColors().black
  );

  TextStyle n414 = TextStyle(
      fontSize: 14,
      fontFamily: '.SF UI Display',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      color: AppColors().black
  );

  TextStyle n414a = TextStyle(
      fontSize: 14,
      fontFamily: '.SF UI Display',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      color: AppColors().transparentBlack
  );

  TextStyle n414b = TextStyle(
      fontSize: 14,
      fontFamily: '.SF UI Display',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      color: AppColors().lightBlack
  );

  TextStyle n414c = TextStyle(
      fontSize: 14,
      fontFamily: '.SF UI Display',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      color: AppColors().mediumBlack
  );

  TextStyle n514 = TextStyle(
      fontSize: 14,
      fontFamily: '.SF UI Display',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      color: AppColors().black
  );

  TextStyle n516 = TextStyle(
      fontSize: 16,
      fontFamily: '.SF UI Display',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      color: AppColors().black
  );

  TextStyle n516a = TextStyle(
      fontSize: 16,
      fontFamily: '.SF UI Display',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      color: AppColors().white
  );

  TextStyle n518 = TextStyle(
      fontSize: 18,
      fontFamily: '.SF UI Display',
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      color: AppColors().black
  );
}