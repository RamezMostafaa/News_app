import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/provider/app_config_provider.dart';
import 'package:news_app/theme/my_theme.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  News newObject;
  Function onTap;

  Function onSearchTap;

  NewsItem(
      {required this.newObject,
      super.key,
      required this.onTap,
      required this.onSearchTap});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return InkWell(
      onTap: () {
        onTap(newObject);
        onSearchTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .25,
                fit: BoxFit.fill,
                imageUrl: newObject.urlToImage!,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    color: MyTheme.primaryLightColor,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: MyTheme.redColor,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(newObject.author ?? "",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: MyTheme.blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                textAlign: TextAlign.justify),
            const SizedBox(
              height: 5,
            ),
            Text(newObject.title ?? "",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: MyTheme.blackColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 18),
                textAlign: TextAlign.justify),
            const SizedBox(
              height: 5,
            ),
            Text(
                timeago.format(
                    DateTime.now().subtract(Duration(
                        hours: DateTime.parse(newObject.publishedAt!).minute)),
                    locale: provider.appLanguage,
                    allowFromNow: true),
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: MyTheme.greyColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
