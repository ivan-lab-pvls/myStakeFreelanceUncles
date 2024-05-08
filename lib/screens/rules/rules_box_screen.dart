import 'package:flutter/material.dart';

import '../components/app_bar_setting_widget.dart';

class RulesBoxPage extends StatelessWidget {
  const RulesBoxPage({super.key});

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
                      Image(image: AssetImage('assets/image/ms_mystery_box/ms_box.png'), width: 98,),

                      SizedBox(height: 20,),
                      Text('Open boxes and get valuable prizes.\nPlace a bet and multiply your winnings.\nYou can open up to 3 boxes in one\nattempt. ', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white),),
                      SizedBox(height: 32,),
                      Image(image: AssetImage('assets/image/ms_mystery_box/rules.png')),
                      SizedBox(height: 20,),
                      Text('The more boxes are opened in one\nattempt, the less the winnings will be\nmultiplied.  Try your luck and intuition!', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white),),

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
