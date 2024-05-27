import 'package:flutter/material.dart';
import 'package:news_app/provider/app_config_provider.dart';
import 'package:news_app/theme/my_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'language_bottom_sheet.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? appLocalizations = AppLocalizations.of(context);
    var provider = Provider.of<AppConfigProvider>(context);

    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50, left: 15),
            child: Text(
              appLocalizations!.language,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: MyTheme.blackColor),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return const FractionallySizedBox(
                      heightFactor: .15,
                      child: ShowLanguageBottomSheet(),
                    );
                  });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: MyTheme.primaryLightColor),
                color: MyTheme.whiteColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      provider.isArLang()
                          ? appLocalizations.arabic
                          : appLocalizations.english,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: MyTheme.primaryLightColor,
                          fontSize: 14,
                          fontWeight: FontWeight.normal)),
                  Icon(Icons.arrow_drop_down, color: MyTheme.primaryLightColor)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
