import 'package:flutter/material.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/theme/my_theme.dart';

class CategoryItem extends StatelessWidget {
  CategoryDM category;
  int index;

  CategoryItem({required this.category, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: category.color,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(25),
            topRight: const Radius.circular(25),
            bottomLeft: Radius.circular(index % 2 == 0 ? 25 : 0),
            bottomRight: Radius.circular(index % 2 == 0 ? 0 : 25),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            category.imagePath,
            height: size.height * .15,
            width: size.width * .40,
            fit: BoxFit.contain,
          ),
          const Spacer(
            flex: 1,
          ),
          Text(
            category.title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: MyTheme.whiteColor,
                  fontSize: 14,
                ),
          )
        ],
      ),
    );
  }
}
