import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_stake/service/hive_service.dart';

import '../settings_screen.dart';

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarState();
}

class _AppBarState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).padding.top + 60,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20)
        ),
        color: Color(0xFF2B2C37)
      ),
      padding: const EdgeInsets.only(bottom: 16, right: 24, left: 24),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ValueListenableBuilder(
            valueListenable: HiveService.getUserListenable(),
            builder: (context, box, child) {
              final user = box.values.first;
              return Row(
                children: [
                  const Image(image: AssetImage('assets/image/ms_money.png'), width: 22,),
                  const SizedBox(width: 8,),
                  Text(user.money.toString(), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.white),),
                ],
              );
            }
          ),
          const Image(image: AssetImage('assets/image/ms_logo.png'), width: 89,),
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SettingPage()),
              );
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF5E6071)
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.settings, color: Colors.white,),
            ),
          )
        ],
      ),
    );
  }
}
