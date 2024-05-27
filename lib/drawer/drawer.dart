import 'package:flutter/material.dart';
import 'package:news_app/drawer/drawer_item.dart';
import 'package:news_app/theme/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyDrawer extends StatelessWidget {
  static int category = 1;

  static int settings = 2;

  Function onSideMenuItemClick;

  MyDrawer({
    required this.onSideMenuItemClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var _appLocalization = AppLocalizations.of(context)!;

    return SafeArea(
      child: NavigationDrawer(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .12,
            color: MyTheme.primaryLightColor,
            child: Center(
                child: Text(
              _appLocalization.news_app,
              style: Theme.of(context).textTheme.titleLarge,
            )),
          ),
          const SizedBox(
            height: 20,
          ),
          DrawerItem(
              icon: Icons.view_list,
              title: _appLocalization.categories,
              onTap: () {
                onSideMenuItemClick(category);
              }),
          const SizedBox(
            height: 20,
          ),
          DrawerItem(
              icon: Icons.settings,
              title: _appLocalization.settings_app_bar,
              onTap: () {
                onSideMenuItemClick(settings);
              }),
        ],
      ),
    );
  }
}
