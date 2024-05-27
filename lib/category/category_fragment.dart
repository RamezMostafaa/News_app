import 'package:flutter/material.dart';
import 'package:news_app/category/category_item.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/theme/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryFragment extends StatelessWidget {
  Function onCategoryItemClick;

  CategoryFragment({required this.onCategoryItemClick, super.key});

  @override
  Widget build(BuildContext context) {
    List<CategoryDM> categoryList = CategoryDM.getCategoryList(context);
    var _appLocalization = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(children: [
        Text(
          _appLocalization.category_desc,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: MyTheme.blackColor),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    onCategoryItemClick(categoryList[index]);
                  },
                  child:
                      CategoryItem(category: categoryList[index], index: index),
                );
              },
              itemCount: categoryList.length),
        ),
      ]),
    );
  }
}
