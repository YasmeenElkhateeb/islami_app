import 'package:flutter/material.dart';
import 'package:islami_app/hadeth/hadeth_details.dart';
import 'package:islami_app/home_screen.dart';
import 'package:islami_app/my_theme_data.dart';
import 'package:islami_app/providers/AppConfigProvider.dart';
import 'package:islami_app/quran/soura_name_details.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:islami_app/settings/language_bottom_sheet.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    child: MyApp(),
    create: (context) => AppConfigProvider(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        SouraNameDetails.routeName: (context) => SouraNameDetails(),
        HadethDetails.routeName: (context) => HadethDetails(),
      },
      initialRoute: HomeScreen.routeName,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.localLanguage),
      themeMode: provider.appMode,
    );
  }
}
