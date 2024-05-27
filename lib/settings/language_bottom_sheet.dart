import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/provider/app_config_provider.dart';
import 'package:provider/provider.dart';

class ShowLanguageBottomSheet extends StatefulWidget {
  const ShowLanguageBottomSheet({super.key});

  @override
  State<ShowLanguageBottomSheet> createState() =>
      _ShowLanguageBottomSheetState();
}

class _ShowLanguageBottomSheetState extends State<ShowLanguageBottomSheet> {
  late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              provider.changeLanguage("en");
            },
            child: provider.appLanguage == "en"
                ? getSelectedItemLanguage(
                    context, AppLocalizations.of(context)!.english)
                : getUnSelectedItemLanguage(
                    context, AppLocalizations.of(context)!.english),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              provider.changeLanguage("ar");
            },
            child: provider.appLanguage == "ar"
                ? getSelectedItemLanguage(
                    context, AppLocalizations.of(context)!.arabic)
                : getUnSelectedItemLanguage(
                    context, AppLocalizations.of(context)!.arabic),
          ),
        ],
      ),
    );
  }

  Widget getSelectedItemLanguage(BuildContext context, String language) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(language,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold)),
        Icon(
          Icons.check,
          size: 35,
          color: Theme.of(context).primaryColor,
        )
      ],
    );
  }

  Widget getUnSelectedItemLanguage(BuildContext context, String language) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(language, style: Theme.of(context).textTheme.titleSmall),
      ],
    );
  }
}
