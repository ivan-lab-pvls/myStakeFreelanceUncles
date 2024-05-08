import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:my_stake/screens/alert/change_name_alert.dart';
import 'package:my_stake/screens/rules/rules_screen.dart';
import 'package:my_stake/service/hive_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../privacy.dart';
import 'components/app_bar_custom_widget.dart';
import 'components/app_bar_setting_widget.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late Box box;
  bool isMusic = false;

  void getBox() async {
    box = await Hive.openBox('myBox');
    if (mounted) {
      setState(() {
        isMusic = box.get('Music');
      });
    }
  }

  @override
  void initState() {
    getBox();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B22),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            AppBarSettingWidget(str: 'Settings',),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 26,),
                    ValueListenableBuilder(
                        valueListenable: HiveService.getUserListenable(),
                        builder: (context, value, child){
                          return Padding(
                            padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Profile', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white, height: 1),),
                                SizedBox(height: 18,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 48,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(7),
                                            color: Color(0xFF2B2C37)
                                          ),
                                          alignment: Alignment.center,
                                          child: Image(image: AssetImage('assets/image/ms_profile_icon.png'), width: 22,),
                                        ),
                                        SizedBox(width: 20,),
                                        Text(value.getAt(0)!.username, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),)
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        final result = await showDialog(
                                          useSafeArea: false,
                                          context: context,
                                          builder: (BuildContext context) {

                                            return ChangeNameAlert();
                                          },
                                        );
                                        if (result != null){
                                          HiveService.changeName(result);
                                        }
                                      },
                                      child: Container(
                                        width: 72,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(7),
                                          color: Color(0xFF2B2C37)
                                        ),
                                        alignment: Alignment.center,
                                        child: Text('Edit', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 16,),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xFF2B2C37)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Your Balance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                                      Row(
                                        children: [
                                          Image(image: AssetImage('assets/image/ms_money.png'), width: 22,),
                                          SizedBox(width: 8,),
                                          Text(value.getAt(0)!.money.toString(), style: TextStyle(fontSize: 16, height: 1, fontWeight: FontWeight.w700, color: Colors.white)),

                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xFF2B2C37)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Place in the ranking', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                                      Text((5409 - value.getAt(0)!.money).toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white, height: 1)),

                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xFF2B2C37)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Best result', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                                      Row(
                                        children: [
                                          Image(image: AssetImage('assets/image/ms_money.png'), width: 22,),
                                          SizedBox(width: 8,),
                                          Text(value.getAt(0)!.maxmoney.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white, height: 1)),

                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                //
                                //
                                //
                                //
                                SizedBox(height: 40,),
                                Text('Main Settings', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white, height: 1),),
                                SizedBox(height: 16,),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xFF2B2C37)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Sound', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                                      GestureDetector(
                                          onTap:(){
                                            //HiveService.updateSound();
                                            isMusic = !isMusic;
                                            box.put('Music', isMusic);
                                            setState(() {});
                                          },
                                          child: Image(image: AssetImage(isMusic? 'assets/image/ms_switch/ms_on.png' : 'assets/image/ms_switch/ms_off.png'), width: 48,))
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                GestureDetector(
                                  onTap: (){

                                    Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => RulesPage()),
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xFF2B2C37)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Rules', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                                  
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                GestureDetector(
                                  onTap: () async {
                                    final Uri url = Uri.parse(privacy);
                                    if (!await launchUrl(url)) {
                                    throw Exception('Could not launch $url');
                                    }
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xFF2B2C37)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Privacy Policy', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                    )
                  ],
                ),
              ),
            ),
            //Align(alignment: Alignment.bottomCenter, child: BottomBarWidget(play: hiddenSymbolsGamePlay, selectI: selectI, stake: stake,)),
          ],
        ),
      ),
    );
  }
}
