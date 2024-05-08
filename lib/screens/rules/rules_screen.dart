import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_stake/screens/rules/rules_box_screen.dart';
import 'package:my_stake/screens/rules/rules_dice_screen.dart';
import 'package:my_stake/screens/rules/rules_hidden_screen.dart';

import '../components/app_bar_setting_widget.dart';

class RulesPage extends StatefulWidget {
  const RulesPage({super.key});

  @override
  State<RulesPage> createState() => _RulesPageState();
}

class _RulesPageState extends State<RulesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B22),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            AppBarSettingWidget(str: 'Rules',),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 26,),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => RulesHiddenPage()),
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
                              Text('Hidden Symbols', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: (){

                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => RulesBoxPage()),
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
                              Text('Mystery Box', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: (){

                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => RulesDicePage()),
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
                              Text('Secret Dice', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
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
