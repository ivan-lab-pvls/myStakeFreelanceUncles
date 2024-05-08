import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../service/hive_service.dart';
import 'alert/win_alert.dart';
import 'components/app_bar_custom_widget.dart';
import 'components/bottom_bar_widget.dart';

class SecretDicePage extends StatefulWidget {
  const SecretDicePage({super.key});

  @override
  State<SecretDicePage> createState() => _SecretDicePageState();
}

class _SecretDicePageState extends State<SecretDicePage> {
  ValueNotifier<bool> hiddenSymbolsGamePlay = ValueNotifier(false);
  ValueNotifier<int> selectI = ValueNotifier(0);
  ValueNotifier<int> stake = ValueNotifier(0);

  Timer? timer;

  int coof = 1;
  int selectHidden = 0;
  int randNum = 0;
  bool roll = false;

  @override
  void initState() {
    hiddenSymbolsGamePlay.value = false;
    super.initState();
  }

  List<int> listint = [0, 1, 2, 3, 4, 5, 6, 10, 12];

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    /*if(randNum != 0){
      Future.delayed(Duration(seconds: 3), (){
        setState(() {
          randNum == 0;
          selectHidden = 0;
          hiddenSymbolsGamePlay.value = false;
        });
      });
    }*/
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B22),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            AppBarCustomWidget(str: 'Secret Dice',),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 26,),
                    Padding(
                      padding: const EdgeInsets.only(left: 36.0, right: 36),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFF2B2C37)
                        ),
                        padding: EdgeInsets.only(top: 14, bottom: 8, left: 26, right: 26),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text('Select a Number', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.white),),
                            SizedBox(height: 11,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                itemSymbol(1, 1, Color(0xFF5E6071)),
                                itemSymbol(2, 1, Color(0xFF5E6071)),
                                itemSymbol(3, 1, Color(0xFF5E6071)),
                                itemSymbol(4, 1, Color(0xFF5E6071))
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                itemSymbol(5, 2, Color(0xFF008FDF)),
                                itemSymbol(6, 2, Color(0xFF008FDF)),
                                itemSymbol(7, 3, Color(0xFF7C23C6)),
                                itemSymbol(8, 4, Color(0xFFFE01C7))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.only(left: 54.0, right: 54),
                      child: SizedBox(
                        width: double.infinity,
                        height: 160,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xFF7501FF)
                                ),
                                child: randNum == 0 ?  Text('Press "Roll the Dice"', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),) :
                                Text(listint[randNum].toString(), style: TextStyle(fontSize: 64, fontWeight: FontWeight.w700, color: Colors.white),)
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Image(image: AssetImage('assets/image/ms_secret_dice/ms_dice_image.png'), width: 60,),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 11,),
                    ValueListenableBuilder(
                        valueListenable: hiddenSymbolsGamePlay,
                        builder: (context, val, child){


                          return GestureDetector(
                            onTap: (){

                              if (roll){

                              } else {
                                timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
                                  setState(() {
                                    randNum = Random().nextInt(8) + 1;
                                  });
                                });
                                setState(() {
                                  roll = true;
                                });

                                Timer(Duration(milliseconds: 1300), () async {
                                  timer?.cancel();
                                  if (selectI.value == randNum){
                                    await showDialog(
                                    useSafeArea: false,
                                    context: context,
                                    builder: (BuildContext context) {

                                      return WinAlert(coof: coof, stake: stake.value,);
                                    },
                                    );
                                    HiveService.updateUserMoney(HiveService.getUser()!.money + stake.value * coof);
                                    hiddenSymbolsGamePlay.value = false;
                                    setState(() {
                                      randNum = 0;
                                      roll = false;

                                    });
                                  } else {
                                    Future.delayed(Duration(seconds: 2), (){
                                      setState(() {
                                        roll = false;
                                        randNum == 0;
                                        selectHidden = 0;
                                        hiddenSymbolsGamePlay.value = false;
                                      });
                                    });
                                  }
                                });
                              }

                            },

                            child: Container(
                              width: 182,
                              height: 48,
                              decoration: val && !roll ? BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                gradient: LinearGradient(
                                  colors: [Color(0xFFE60BEB), Color(0xFFBC29BF)],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF970877),
                                    offset: Offset(0, 4),
                                    blurRadius: 0
                                  )
                                ]
                              ) : BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Color(0xFF3B3B3B),
                              ),
                              alignment: Alignment.center,
                              child: Text('Roll the Dice', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.white),),
                            ),
                          );
                        }
                    ),
                    SizedBox(height: 10,),

                  ],
                ),
              ),
            ),
            Align(alignment: Alignment.bottomCenter, child: BottomBarWidget(play: hiddenSymbolsGamePlay, selectI: selectI, stake: stake,)),
          ],
        ),
      ),
    );
  }
  Widget itemSymbol(int i, int ix, Color colorset){
    return GestureDetector(
      onTap: (){
        setState(() {
          selectI.value = i;
          coof = ix;
        });
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 2*(32+24) - 12 * 3) / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: i == selectI.value ? [Colors.white, Colors.white.withOpacity(0.2)] : [Colors.transparent, Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.only(top: 2, bottom: 2),
        alignment: Alignment.center,
        child: Container(
          width: (MediaQuery.of(context).size.width - 2*(32+24) - 12 * 3 - 8 * 2) / 4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: Color(0xFF2B2C37)
          ),
          padding: EdgeInsets.all(6),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                width: (MediaQuery.of(context).size.width - 2*(32+24) - 12 * 3 - 8 * 2) / 4 - 12,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: colorset,

                ),
                alignment: Alignment.center,
                child: Text(listint[i].toString(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white),),
              ),
              SizedBox(height: 5,),
              Text('x$ix', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white, height: 1),)
            ],
          ),
        ),
      ),
    );
  }
}