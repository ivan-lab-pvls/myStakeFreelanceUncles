import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_stake/screens/main_screen.dart';
import 'package:my_stake/service/hive_service.dart';

import 'components/widgets.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with SingleTickerProviderStateMixin{

  late AnimationController _controller;


  late Box box;

  void getBox() async {
    box = await Hive.openBox('myBox');
  }
  @override
  void initState() {
    getBox();
    super.initState();
    load();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500), // Duration of one full spin
      vsync: this,
    )..repeat(); // This will start the rotation and repeat indefinitely
  }

  @override
  void dispose() {
    _controller.dispose(); // Don't forget to dispose of the controller
    super.dispose();
  }

  Future<void> load() async{

    Future.delayed(const Duration(milliseconds: 2000), (){
      if ( HiveService.getUser() != null){
        print('user here');
      } else {
        box.put('Music', false);
        HiveService.addZeroUser();
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>  const MusicPlayer(child: MainPage(),) ),
      );
    });


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1B22),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage('assets/image/ms_logo.png'), width: 160,),
            const SizedBox(height: 70,),
            RotationTransition(
              turns: Tween(begin: 0.0, end: -1.0).animate(_controller),
              child: const Image(image: AssetImage('assets/image/ms_loading_indicator.png'), width: 48,),
            )
          ],
        ),
      ),
    );
  }
}
