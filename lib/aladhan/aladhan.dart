import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:islami_app/model/AladhanResponse.dart';
import 'package:provider/provider.dart';

import '../api/api_manger.dart';
import '../my_theme_data.dart';
import '../providers/AppConfigProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Aladhan extends StatefulWidget{
  static const String routeName = 'aladhan';

  @override
  State<Aladhan> createState() => _AladhanState();
}

class _AladhanState extends State<Aladhan> {
  var  audioPlayer = AudioPlayer();
  var timeFajr;
  var timeDhuhr;
  var timeAsr;
  var timeMaghrib;
  var timeIsha;
  @override
  void initState() {
    super.initState();
    playAudio();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // var provider =Provider.of<AppConfigProvider>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            flex: 1,
            child: Center(child: Image.asset('assets/images/adhan.png'))),
        Divider(
          thickness: 4,
          color: MyTheme.goldColor,
        ),
        Text(
          AppLocalizations.of(context)!.aladhan,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Divider(
          thickness: 4,
          color: MyTheme.goldColor,
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          flex:2,
            child: FutureBuilder<AladhanResponse>(
                future: ApiManger.getPrayTime('Alexandria', 'Egypt'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Column(
                      children: [
                        Text('Someting Wrong'),
                        ElevatedButton(onPressed: () {}, child: Text('Try Again'))
                      ],
                    );
                  }
                  if (snapshot.data?.status != 'OK') {
                    return Column(
                      children: [
                        Text(snapshot.data?.status ?? ''),
                        ElevatedButton(onPressed: () {}, child: Text('Try Again'))
                      ],
                    );
                  }

                  var hijiry = snapshot.data?.data?.date?.hijri;
                  var pray = snapshot.data?.data?.timings;
                  timeFajr=pray?.fajr;
                  timeDhuhr=pray?.dhuhr;
                  timeAsr=pray?.asr;
                  timeMaghrib=pray?.maghrib;
                  timeIsha=pray?.isha;


                  return Column(
                    children: [
                      Text('${hijiry?.weekday?.ar} (${hijiry?.day} - ${hijiry?.month?.ar} - ${hijiry?.year} )'),
                       Divider(
                          thickness: 1,
                           color: MyTheme.goldColor,
                       ),
                      Text('fajr : ${pray?.fajr}'),
                      // InkWell(onTap:playAudio ,child: Text('Done'),),

                      Divider(
                        thickness: 1,
                        color: MyTheme.goldColor,
                      ),
                      Text('dhuhr : ${pray?.dhuhr}'),
                      Divider(
                        thickness: 1,
                        color: MyTheme.goldColor,
                      ),
                      Text('asr : ${pray?.asr}'),
                      Divider(
                        thickness: 1,
                        color: MyTheme.goldColor,
                      ),
                      Text('maghrib : ${pray?.maghrib}'),
                      Divider(
                        thickness: 1,
                        color: MyTheme.goldColor,
                      ),
                      Text('isha : ${pray?.isha}'),
                    ],
                  )
                    ;
                }),
        )


      ],
    );

  }
  void playAudio()async{

    if(DateTime.parse('${timeFajr}') == DateTime.now ||DateTime.parse('${timeDhuhr}')== DateTime.now ||DateTime.parse('${timeAsr}')  == DateTime.now ||
        DateTime.parse('${timeMaghrib}')== DateTime.now||DateTime.parse('${timeIsha}')== DateTime.now ){
    //   await audioPlayer.play(AssetSource('assets/audio/azan2.mp3'));
    // await audioPlayer.setSourceAsset('assets/audio/azan2.mp3');
    await audioPlayer.play(UrlSource('https://www.islamcan.com/audio/adhan/azan2.mp3'));
    };
  }

}
