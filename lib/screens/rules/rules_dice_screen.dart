import 'package:flutter/material.dart';

import '../components/app_bar_setting_widget.dart';

class RulesDicePage extends StatelessWidget {
  const RulesDicePage({super.key});

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
                      Image(image: AssetImage('assets/image/ms_secret_dice/ms_dice_image.png'), width: 60,),

                      SizedBox(height: 20,),
                      Text('Roll the dice and guess the number you\nneed. If the number you wished for comes\nup, you win and the winnings are\nmultiplied depending on your choice. ', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white),),
                      SizedBox(height: 32,),
                      Image(image: AssetImage('assets/image/ms_secret_dice/rules.png')),
                      SizedBox(height: 20,),
                      Text('You can multiply your winnings by\nchoosing the rarest numbers. Try your\nluck! Forward to the victory!', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white),),

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
