import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/model/NewsResponse.dart';
import 'package:news_app/provider/app_config_provider.dart';
import 'package:news_app/theme/my_theme.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsItemDetails extends StatelessWidget {
  News newObject;

  NewsItemDetails({required this.newObject, super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var _appLocalization = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Hero(
              tag: newObject.title!,
              child: CachedNetworkImage(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .40,
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
            height: 15,
          ),
          Text(
              timeago.format(
                  DateTime.now().subtract(Duration(
                      hours: DateTime.parse(newObject.publishedAt!).minute)),
                  locale: provider.appLanguage,
                  allowFromNow: true),
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: MyTheme.blackColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Text(newObject.description ?? "",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: MyTheme.blackColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 18),
                textAlign: TextAlign.justify),
          ),
          InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _appLocalization.view_full_article,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: MyTheme.blackColor, fontSize: 18),
                ),
                Icon(Icons.arrow_right, color: MyTheme.blackColor)
              ],
            ),
            onTap: () {
              launchNewsUrl(newObject.url ?? "");
            },
          )
        ],
      ),
    );
  }

  Future<void> launchNewsUrl(String url) async {
    await launchUrl(Uri.parse(url));
  }
}
