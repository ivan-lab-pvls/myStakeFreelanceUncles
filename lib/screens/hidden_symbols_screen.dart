import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_stake/screens/alert/win_alert.dart';
import 'package:my_stake/screens/components/app_bar_custom_widget.dart';
import 'package:my_stake/screens/components/bottom_bar_widget.dart';
import 'package:my_stake/screens/components/flip_card_widget.dart';
import 'package:my_stake/service/hive_service.dart';

ValueNotifier<bool> hiddenSymbolsGamePlay = ValueNotifier(false);
ValueNotifier<int> selectI = ValueNotifier(0);
ValueNotifier<int> stake = ValueNotifier(0);
bool openS = false;
int coof = 1;
int selectHidden = 0;
int rand = 1;
class HiddenSymboldPage extends StatefulWidget {
  const HiddenSymboldPage({super.key});

  @override
  State<HiddenSymboldPage> createState() => _HiddenSymboldPageState();
}

class _HiddenSymboldPageState extends State<HiddenSymboldPage> {





  @override
  void initState() {
    openS = false;
    coof = 1;
    selectHidden = 1;
    rand = 1;
    selectI.value = 0;
    stake.value = 0;
    hiddenSymbolsGamePlay.value = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(selectHidden != 0){
      Future.delayed(Duration(seconds: 1), (){
        setState(() {
          selectHidden = 0;
          hiddenSymbolsGamePlay.value = false;
        });
      });
    }
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B22),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            AppBarCustomWidget(str: 'Hidden Symbold',),
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
                            Text('Select a symnol', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.white),),
                            SizedBox(height: 11,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                itemSymbol(1, 1, 'assets/image/ms_hidden_symbols/s1.png'),
                                itemSymbol(2, 2, 'assets/image/ms_hidden_symbols/s2.png'),
                                itemSymbol(3, 3, 'assets/image/ms_hidden_symbols/s3.png'),
                                itemSymbol(4, 1, 'assets/image/ms_hidden_symbols/s4.png')
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                itemSymbol(5, 2, 'assets/image/ms_hidden_symbols/s5.png'),
                                itemSymbol(6, 4, 'assets/image/ms_hidden_symbols/s6.png'),
                                itemSymbol(7, 2, 'assets/image/ms_hidden_symbols/s7.png'),
                                itemSymbol(8, 1, 'assets/image/ms_hidden_symbols/s8.png')
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.only(left: 44.0, right: 44.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HiddenCard(index: 1,),
                              HiddenCard(index: 2,),
                              HiddenCard(index: 3,),
                              HiddenCard(index: 4,),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HiddenCard(index: 5,),
                              HiddenCard(index: 6,),
                              HiddenCard(index: 7,),
                              HiddenCard(index: 8,),
                            ],
                          ),
                        ],
                      ),
                    )
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
  Widget itemSymbol(int i, int ix, String image){
    return GestureDetector(
      onTap: (){
        setState(() {
          selectI.value = i;
          coof = ix;
        });
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 2*(32+26) - 30) / 4,
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
          width: (MediaQuery.of(context).size.width - 2*(32+26) - 30 - 8 * 2) / 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Color(0xFF2B2C37)
          ),
          padding: EdgeInsets.all(6),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: i == selectI.value ? Color(0xFFE60BEB) : Colors.transparent,
                      width: 2
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: i == selectI.value ? Color(0xFFE60BEB) : Colors.transparent,
                        offset:  Offset(0, 2),
                        blurRadius: 8
                      )
                    ]
                  ),
                  child: Image(image: AssetImage(image))),
              SizedBox(height: 5,),
              Text('x$ix', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white, height: 1),)
            ],
          ),
        ),
      ),
    );
  }

  Widget hiddenItem(int index){

    return GestureDetector(
      onTap: () async {
        if (hiddenSymbolsGamePlay.value){
          // do som

          Random random = Random();
          setState(() {
            rand = random.nextInt(8) + 1;
            print(rand);
          });
          if (rand == selectI.value){
            await showDialog(
              useSafeArea: false,
              context: context,
              builder: (BuildContext context) {

                return WinAlert(coof: coof, stake: stake.value,);
              },
            );
            HiveService.updateUserMoney(HiveService.getUser()!.money + stake.value * coof);
            hiddenSymbolsGamePlay.value = false;
          } else {
            print(stake.value);
            setState(() {
              selectHidden = index;
            });
          }
        }
      },
      child: Container(
        width: (MediaQuery.of(context).size.width -  88 - 10*3) / 4,
        height: (MediaQuery.of(context).size.width -  88 - 10*3) / 4,
        decoration: selectHidden != index ? BoxDecoration(
          borderRadius: BorderRadius.circular(18.37),
          image: DecorationImage(
            image: AssetImage('assets/image/ms_hidden_symbols/ms_close.png')
          )
        ) : BoxDecoration(
            borderRadius: BorderRadius.circular(18.37),
          color: Color(0xFFB1001F)
        ),
        alignment: Alignment.center,
        child: selectHidden == index ? Image(image: AssetImage('assets/image/ms_hidden_symbols/s$rand.png'), width: 44,) : SizedBox(),
      )
    );
  }
}

class HiddenCard extends StatefulWidget {
  final int index;
  const HiddenCard({super.key, required this.index});

  @override
  State<HiddenCard> createState() => _hiddenCardState();
}

class _hiddenCardState extends State<HiddenCard> {
  final controller1 = FlipCardController();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {


          if (hiddenSymbolsGamePlay.value){
            // do som
            if (!openS){
              openS = true;
              Random random = Random();
              setState(() {
                rand = random.nextInt(8) + 1;
                print(rand);
              });
              if (rand == selectI.value){

                await showDialog(
                  useSafeArea: false,
                  context: context,
                  builder: (BuildContext context) {

                    return WinAlert(coof: coof, stake: stake.value,);
                  },
                );
                HiveService.updateUserMoney(HiveService.getUser()!.money + stake.value * coof);
                hiddenSymbolsGamePlay.value = false;
                openS = false;
              } else {
                controller1.flipCard();
                print(stake.value);
                Future.delayed(Duration(seconds: 1), (){
                  setState(() {

                    selectHidden = 0;
                    hiddenSymbolsGamePlay.value = false;
                    openS = false;
                  });
                });
                setState(() {
                  selectHidden = widget.index;
                });
              }
            }


          }



      },
      child: ValueListenableBuilder(
        valueListenable: hiddenSymbolsGamePlay,
        builder: (context, value, child) {
          if (!value){
            //open = false;
            openS = false;
            controller1.flipbackCard();
          }
          return FlipCardWidget(
            back:  Container(
              width: (MediaQuery.of(context).size.width -  88 - 10*3) / 4,
              height: (MediaQuery.of(context).size.width -  88 - 10*3) / 4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.37),
                  color: Color(0xFFB1001F)
              ),
              alignment: Alignment.center,
              child: selectHidden == widget.index ? Image(image: AssetImage('assets/image/ms_hidden_symbols/s$rand.png'), width: (MediaQuery.of(context).size.width -  88 - 10*3) / 4 - 20,) : SizedBox(),
            ),
            front: Container(
              width: (MediaQuery.of(context).size.width -  88 - 10*3) / 4,
              height: (MediaQuery.of(context).size.width -  88 - 10*3) / 4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18.37),
                  image: DecorationImage(
                      image: AssetImage('assets/image/ms_hidden_symbols/ms_close.png')
                  )
              )
            ),
            controller: controller1,

          );
        }
      ),
    );
  }
}
