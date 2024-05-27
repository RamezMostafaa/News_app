import 'package:flutter/material.dart';
import 'package:news_app/theme/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryDM {
  String? id;
  String title;
  String imagePath;
  Color color;

  CategoryDM(
      {required this.id,
      required this.title,
      required this.imagePath,
      required this.color});

  static getCategoryList(BuildContext context) {
    var _appLocalization = AppLocalizations.of(context)!;

    return [
      CategoryDM(
          id: "business",
          title: _appLocalization.business_category,
          imagePath: "assets/bussines.png",
          color: MyTheme.brownColor),
      CategoryDM(
          id: "entertainment",
          title: _appLocalization.entertainment_category,
          imagePath: "assets/entertainment.png",
          color: MyTheme.redColor),
      CategoryDM(
          id: "general",
          title: _appLocalization.general_category,
          imagePath: "assets/environment.png",
          color: MyTheme.greyColor),
      CategoryDM(
          id: "health",
          title: _appLocalization.health_category,
          imagePath: "assets/health.png",
          color: MyTheme.pinkColor),
      CategoryDM(
          id: "science",
          title: _appLocalization.science_category,
          imagePath: "assets/science.png",
          color: MyTheme.blueColor),
      CategoryDM(
          id: "sports",
          title: _appLocalization.sports_category,
          imagePath: "assets/ball.png",
          color: MyTheme.darkBlueColor),
      CategoryDM(
          id: "technology",
          title: _appLocalization.technology_category,
          imagePath: "assets/technology.png",
          color: MyTheme.primaryLightColor),
    ];
  }
}
