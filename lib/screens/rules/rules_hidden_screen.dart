import 'package:flutter/material.dart';

import '../components/app_bar_setting_widget.dart';

class RulesHiddenPage extends StatelessWidget {
  const RulesHiddenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B22),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: const Column(
          children: [
            AppBarSettingWidget(str: 'Rules',),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 24.0, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 36,),
                      Row(
                        children: [
                          Image(image: AssetImage('assets/image/ms_hidden_symbols/s1.png'), width: 48,),
                          SizedBox(width: 20,),
                          Image(image: AssetImage('assets/image/ms_hidden_symbols/s2.png'), width: 48,),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text('You need to find the hidden symbol that\nis in one of the cards. ', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white),),
                      SizedBox(height: 32,),
                      Image(image: AssetImage('assets/image/ms_hidden_symbols/ms_close.png'), width: 68,),
                      SizedBox(height: 20,),
                      Text('Place a bet and increase your winnings\ndepending on the coefficient of the\nsymbol itself, which can be x1, x2, x3, x4.\nThe higher the bet, the more you can win.  One bet per try. Try your luck! ', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white),),

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
