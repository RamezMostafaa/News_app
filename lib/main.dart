import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/home_screen.dart';
import 'package:news_app/my_bloc_observer.dart';
import 'package:news_app/provider/app_config_provider.dart';
import 'package:news_app/theme/my_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  Bloc.observer = MyBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isEnglish = prefs.getBool("isEnglish") ?? false;
  timeago.setLocaleMessages('ar', timeago.ArMessages());
`
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => AppConfigProvider(isEnglish),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return MaterialApp(
      locale: Locale(provider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTeme,
      initialRoute: HomeScreen.initialRoute,
      routes: {
        HomeScreen.initialRoute: (context) => const HomeScreen(),
      },
    );
  }
}
