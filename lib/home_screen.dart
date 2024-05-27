import 'package:flutter/material.dart';
import 'package:news_app/category/category_details.dart';
import 'package:news_app/category/category_fragment.dart';
import 'package:news_app/drawer/drawer.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/news/news_item_details.dart';
import 'package:news_app/settings/setting_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'search_delegate.dart';

class HomeScreen extends StatefulWidget {
  static const String initialRoute = "homePage";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var _appLocalization = AppLocalizations.of(context)!;
    return Stack(children: [
      Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Image.asset("assets/pattern.png", fit: BoxFit.cover),
      ),
      Scaffold(
          drawer: MyDrawer(onSideMenuItemClick: onMenuItemClick),
          appBar: AppBar(
              title: Text(selectedMenuItem == MyDrawer.settings
                  ? _appLocalization.settings_app_bar
                  : selectedCategory != null
                      ? selectedCategory!.title
                      : newsObject != null
                          ? newsObject!.title!
                          : _appLocalization.news_app),
              actions: (selectedCategory != null &&
                      selectedMenuItem != MyDrawer.settings &&
                      newsObject == null)
                  ? [
                      IconButton(
                          onPressed: () {
                            showSearch(
                                context: context,
                                delegate: MysearchDelegate(onTap: onNewsClick));
                          },
                          icon: const Icon(
                            Icons.search,
                            size: 40,
                          ))
                    ]
                  : []),
          backgroundColor: Colors.transparent,
          body: newsObject != null
              ? NewsItemDetails(newObject: newsObject!)
              : selectedMenuItem == MyDrawer.settings
                  ? const SettingsTab()
                  : selectedCategory == null
                      ? CategoryFragment(
                          onCategoryItemClick: onCategoryItemClick,
                        )
                      : CategoryDetails(
                          category: selectedCategory!, onTap: onNewsClick))
    ]);
  }

  News? newsObject;

  int selectedMenuItem = 0;

  CategoryDM? selectedCategory;

  void onCategoryItemClick(CategoryDM newSelectedCategory) {
    selectedCategory = newSelectedCategory;
    newsObject = null;
    selectedMenuItem = 0;

    setState(() {});
  }

  void onMenuItemClick(int newSelectedMenuItem) {
    selectedMenuItem = newSelectedMenuItem;
    selectedCategory = null;
    newsObject = null;

    Navigator.of(context).pop();
    setState(() {});
  }

  void onNewsClick(News newSelectedNews) {
    selectedMenuItem = 0;
    selectedCategory = null;
    newsObject = newSelectedNews;
    print(newSelectedNews.title);
    setState(() {});
  }
}
