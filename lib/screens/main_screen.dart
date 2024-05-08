import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:my_stake/screens/components/app_bar_widget.dart';
import 'package:my_stake/screens/hidden_symbols_screen.dart';
import 'package:my_stake/screens/secret_dice_screen.dart';
import 'package:my_stake/screens/wheel_of_fortune_screen.dart';

import 'components/menu_item_widget.dart';
import 'mystery_box_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  late Box box;
  late AppLifecycleState _lastState;
  bool flagM = false;
  bool isMusicc = false;
  void getBox() async {
    box = await Hive.openBox('myBox');
    setState(() {
      isMusicc = box.get('Music');

      if (isMusicc) {
        flagM = true;
      }
    });
  }
  void onSwitchMusic() async {
    isMusicc = !isMusicc;
    box.put('Music', isMusicc);
    setState(() {});
  }
  @override
  initState(){
    WidgetsBinding.instance!.addObserver(this);
    getBox();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    super.initState();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      isMusicc = box.get('Music');
      if (isMusicc) {
        flagM = true;
      } else {
        flagM = false;
      }
      if (flagM){
        onSwitchMusic();
      }

    } else if (state == AppLifecycleState.resumed) {
      if (flagM){
        onSwitchMusic();
      }

    }

    if (state == AppLifecycleState.resumed && _lastState == AppLifecycleState.paused) {
    }
    _lastState = state;
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
            const AppBarWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 25,),
                      GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => HiddenSymboldPage()),
                            );
                          },
                          child: const MenuItemWiget(str: 'HIDDEN\nSYMBOLS', image: 'assets/image/ms_menu/ms_hidden_symbols.png', wheel: false,)
                      ),
                      GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => MysteryBoxPage()),
                            );
                          },
                          child: const MenuItemWiget(str: 'MYSTERY\nBOX', image: 'assets/image/ms_menu/ms_mystery_box.png', wheel: false,)
                      ),
                      GestureDetector(
                          onTap:(){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => SecretDicePage()),
                            );
                          },
                          child: const MenuItemWiget(str: 'SECRET\nDICE', image: 'assets/image/ms_menu/ms_secret_dice.png', wheel: false,)
                      ),
                      GestureDetector(
                          onTap:(){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => WheelOfFortunePage()),
                            );
                          },
                          child: const MenuItemWiget(str: 'WHEEL\nOF FORTUNE', image: 'assets/image/ms_menu/ms_wheel_of_fortune.png', wheel: true,)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
