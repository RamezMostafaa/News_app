import 'package:flutter/material.dart';
import 'package:news_app/model/sourceResponse.dart';
import 'package:news_app/theme/my_theme.dart';

class TabItem extends StatelessWidget {
  bool isSelected;
  Source source;

  TabItem({required this.source, required this.isSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: isSelected ? MyTheme.primaryLightColor : MyTheme.whiteColor,
          border: Border.all(color: MyTheme.primaryLightColor, width: 2),
          borderRadius: BorderRadius.circular(15)),
      child: Text(
        source.name ?? "",
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: isSelected ? MyTheme.whiteColor : MyTheme.primaryLightColor),
      ),
    );
  }
}
