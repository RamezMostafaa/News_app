import 'package:flutter/material.dart';
import 'package:news_app/theme/my_theme.dart';

class DrawerItem extends StatelessWidget {
  String title;
  IconData icon;
  Function onTap;

  DrawerItem(
      {required this.onTap,
      required this.icon,
      required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Icon(
            icon,
            color: MyTheme.blackColor,
            size: 35,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: MyTheme.blackColor,
                ),
          )
        ],
      ),
    );
  }
}
