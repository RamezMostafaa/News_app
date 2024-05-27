import 'package:flutter/material.dart';
import 'package:news_app/api/api_manager.dart';
import 'package:news_app/home_screen.dart';
import 'package:news_app/news/news_item.dart';
import 'package:news_app/theme/my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MysearchDelegate extends SearchDelegate {
  Function onTap;

  MysearchDelegate({required this.onTap});

  @override
  Widget? buildLeading(BuildContext context1) => IconButton(
      onPressed: () => close(context1, null),
      icon: const Icon(Icons.arrow_back));

  @override
  List<Widget>? buildActions(BuildContext context1) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                close(context1, null);
              } else {
                query = "";
              }
            },
            icon: const Icon(Icons.close))
      ];

  @override
  Widget buildResults(BuildContext context1) => const Center();
  String? input;
  dynamic result;

  @override
  Widget buildSuggestions(BuildContext context1) {
    input = query;
    var _appLocalization = AppLocalizations.of(context1);

    return FutureBuilder(
      future: ApiManager.getNewsBySearch(searchArticle: input ?? ""),
      builder: (context1, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: MyTheme.primaryLightColor),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _appLocalization!.something_went_wrong,
                  style: Theme.of(context1).textTheme.titleMedium,
                ),
                ElevatedButton(
                  onPressed: () {
                    ApiManager.getNewsBySearch(searchArticle: input ?? "");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context1).primaryColor),
                  child: Text(
                    _appLocalization.try_again,
                    style: Theme.of(context1).textTheme.titleMedium,
                  ),
                )
              ],
            ),
          );
        } else if (snapshot.data?.status != "ok") {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  snapshot.data!.message!,
                  style: Theme.of(context1).textTheme.titleMedium,
                ),
                ElevatedButton(
                  onPressed: () {
                    ApiManager.getNewsBySearch(searchArticle: input ?? "");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context1).primaryColor),
                  child: Text(
                    _appLocalization!.try_again,
                    style: Theme.of(context1).textTheme.titleMedium,
                  ),
                )
              ],
            ),
          );
        }

        var news = snapshot.data?.news ?? [];

        return news.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.only(bottom: 10),
                itemBuilder: (context, index) {
                  return NewsItem(
                      newObject: news[index],
                      onTap: onTap,
                      onSearchTap: () {
                        close(context1, null);
                      });
                },
                itemCount: news.length,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.do_not_disturb_on_outlined,
                    size: 200,
                    color: MyTheme.redColor,
                  ),
                  Text(
                    _appLocalization!.not_found,
                    textAlign: TextAlign.center,
                    style: Theme.of(context1)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: MyTheme.blackColor),
                  )
                ],
              );
      },
    );
  }
}
