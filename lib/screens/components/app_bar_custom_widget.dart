import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../settings_screen.dart';

class AppBarCustomWidget extends StatelessWidget {
  final String str;
  const AppBarCustomWidget({super.key, required this.str});

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
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              height: 36,
              width: 71,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF5E6071)
              ),
              alignment: Alignment.center,
              child: const Text('Back', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.white),)
            ),
          ),
          Text(str, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white),),
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SettingPage()),
              );
            },
            child: Container(
              width: 71,
              height: 36,
              alignment: Alignment.centerRight,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF5E6071)
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.settings, color: Colors.white,), //Image(image: AssetImage('assets/image/ms_icon_info.png'), width: 20,)
              ),
            ),
          )
        ],
      ),
    );
  }
}
