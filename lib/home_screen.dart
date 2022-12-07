import 'package:flutter/material.dart';
import 'package:islami_app/hadeth/hadeth_tap.dart';
import 'package:islami_app/my_theme_data.dart';
import 'package:islami_app/providers/AppConfigProvider.dart';
import 'package:islami_app/quran/quran_tap.dart';
import 'package:islami_app/radio/radio_tap.dart';
import 'package:islami_app/sebha/sebha_tap.dart';
import 'package:islami_app/settings/settings_tap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int iconSelectIndex = 0;
  List<Widget> taps = [
    QuranTab(),
    HadethTap(),
    SebhaTap(),
    RadioTap(),
    SettingsTap()
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Stack(
      children: [
        provider.appMode == ThemeMode.light
            ? Image.asset(
                'assets/images/background_theme.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
              )
            : Image.asset(
                'assets/images/dark_background_theme.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
              ),
        Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.islami,
              style: Theme.of(context).textTheme.headline1,
            ),
            centerTitle: true,
          ),
          body: taps[iconSelectIndex],
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(canvasColor: MyTheme.goldColor),
            child: BottomNavigationBar(
              currentIndex: iconSelectIndex,
              onTap: (index) {
                iconSelectIndex = index;
                setState(() {});
              },
              items: [
                BottomNavigationBarItem(
                    icon: Image.asset('assets/images/icon_quran.png'),
                    label: AppLocalizations.of(context)!.quran),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/images/icon_hadeth.png'),
                    label: AppLocalizations.of(context)!.hadeth),
                BottomNavigationBarItem(
                    icon: Image.asset('assets/images/icon_sebha.png'),
                    label: AppLocalizations.of(context)!.tasbeeh),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/icon_radio.png'),
                  label: AppLocalizations.of(context)!.radio,
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('assets/images/icon_settings.png'),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
