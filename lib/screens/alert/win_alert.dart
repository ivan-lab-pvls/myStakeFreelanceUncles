import 'package:flutter/material.dart';

class WinAlert extends StatelessWidget {
  final int coof;
  final int stake;
  const WinAlert({super.key, required this.coof, required this.stake});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: OverflowBox(
                minWidth: 0.0,
                minHeight: 0.0,
                maxWidth: double.infinity,
                maxHeight: 340,
                child: Image(image: AssetImage('assets/image/ms_win_back.png'),)
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('You Win!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white),),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('assets/image/ms_money.png'), width: 15,),
                    SizedBox(width: 8,),
                    Text((stake*coof).toString(), style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white, fontSize: 12),)
                  ],
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 140,
                    height: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [Color(0xFF00AAEB), Color(0xFFE60BEB)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight
                      )
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Recieve',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
