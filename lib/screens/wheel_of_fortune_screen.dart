import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../service/hive_service.dart';
import 'alert/win_alert.dart';
import 'components/app_bar_custom_widget.dart';

class WheelOfFortunePage extends StatefulWidget {
  const WheelOfFortunePage({super.key});

  @override
  State<WheelOfFortunePage> createState() => _WheelOfFortunePageState();
}

class _WheelOfFortunePageState extends State<WheelOfFortunePage>  with SingleTickerProviderStateMixin {
  ValueNotifier<bool> hiddenSymbolsGamePlay = ValueNotifier(false);
  ValueNotifier<int> selectI = ValueNotifier(0);
  ValueNotifier<int> stake = ValueNotifier(0);
  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer _timer;
  Duration _timeDifference = Duration();

  bool valuer = false;
  int coof = 1;
  int selectHidden = 0;
  int rand = 1;


  @override
  void initState() {
    _timeDifference = DateTime(HiveService.getUser()!.dailyspin.year,
        HiveService.getUser()!.dailyspin.month,
        HiveService.getUser()!.dailyspin.day + 1,
        HiveService.getUser()!.dailyspin.hour,
        HiveService.getUser()!.dailyspin.minute,
        HiveService.getUser()!.dailyspin.second
    ).difference(DateTime.now());
    //print(_timeDifference < Duration(days: 1));
    if (_timeDifference.compareTo(Duration(seconds: 1)) < 0){
      setState(() {
        valuer = false;
      });
    } else {
      setState(() {
        valuer = true;
      });
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timeDifference = DateTime(HiveService.getUser()!.dailyspin.year,
            HiveService.getUser()!.dailyspin.month,
            HiveService.getUser()!.dailyspin.day + 1,
            HiveService.getUser()!.dailyspin.hour,
            HiveService.getUser()!.dailyspin.minute,
            HiveService.getUser()!.dailyspin.second
        ).difference(DateTime.now());
        //print(_timeDifference < Duration(days: 1));
        if (_timeDifference.compareTo(Duration(seconds: 1)) < 0){
          setState(() {
            valuer = false;
          });
        } else {
          setState(() {
            valuer = true;
          });
        }
      });
    });
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 2 * pi * 5.55).animate(
        CurvedAnimation(parent: _controller, curve: Curves.decelerate)
    ); // Вращается 5 полных оборотов
    hiddenSymbolsGamePlay.value = false;
    super.initState();
  }
  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  void startSpinning() {
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    /*if(selectHidden != 0){
      Future.delayed(Duration(seconds: 1), (){
        setState(() {
          selectHidden = 0;
          hiddenSymbolsGamePlay.value = false;
        });
      });
    }

     */
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B22),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            AppBarCustomWidget(str: 'Wheel of Fortune',),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 1632 / 1190,
                        child: Stack(
                          children: [
                            Center(child: Image(image: AssetImage('assets/image/ms_wheel_of_fortune/ms_circle_back.png'))),
                            Center(child: Image(image: AssetImage('assets/image/ms_wheel_of_fortune/ms_your_win_circle.png'), width: MediaQuery.of(context).size.width / 3,)),
                            Center(
                              child: AnimatedBuilder(
                                animation: _animation,
                                builder: (context, child) {
                                  return Transform.rotate(
                                    angle: _animation.value,
                                    child: child,
                                  );
                                },
                                child: Image(image: AssetImage('assets/image/ms_wheel_of_fortune/ms_circle.png'), width: MediaQuery.of(context).size.width / 1.3,),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 36.0),
                                child: Image(image: AssetImage('assets/image/ms_wheel_of_fortune/ms_arrow.png'), width: MediaQuery.of(context).size.width / 3,),
                              ),
                            ),
                          ],
                        )
                    ),
                    GestureDetector(
                      onTap: (){
                        if (!valuer){
                          startSpinning();
                          Future.delayed(Duration(milliseconds: 5500), () async {
                            await showDialog(
                              useSafeArea: false,
                              context: context,
                              builder: (BuildContext context) {

                                return WinAlert(coof: 1, stake: 100,);
                              },
                            );
                            HiveService.updateUserMoney(HiveService.getUser()!.money + 100 * 1);
                            HiveService.updateDateTime(DateTime.now());
                          });
                        }

                      },
                      child: Container(
                        width: 220,
                        height: 52,
                        decoration: !valuer ? BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: LinearGradient(
                              colors: [Color(0xFF00AAEB), Color(0xFFE60BEB)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF8D1890),
                                  offset: Offset(0, 4),
                                  blurRadius: 0
                              )
                            ]
                        ) : BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color(0xFF3D3A5F)
                
                        ),
                        alignment: Alignment.center,
                        child: !valuer ? Text('Play', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 16),) :
                        Text('Next Spin in ${formatDuration(_timeDifference)}', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 16),),
                      ),
                    ),
                    SizedBox(height: 30,),
                    Text('This is a daily quiz where you can try\nyour luck and win the coins you need.\nIt is carried out only once a day!', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.white.withOpacity(0.6)), textAlign: TextAlign.center,),
                
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
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
