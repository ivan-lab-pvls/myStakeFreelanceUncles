import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../service/hive_service.dart';

class MenuItemWiget extends StatefulWidget {
  final String str;
  final String image;
  final bool wheel;
  const MenuItemWiget({super.key, required this.str, required this.image, required this.wheel});

  @override
  State<MenuItemWiget> createState() => _MenuItemWigetState();
}

class _MenuItemWigetState extends State<MenuItemWiget> {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Timer _timer;
  Duration _timeDifference = Duration();
  bool valuer = false;

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
  }
  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        width: (MediaQuery.of(context).size.width - 48),
        height: (MediaQuery.of(context).size.width - 48) * 110 / 345,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Image(image: AssetImage(widget.image)),
            !widget.wheel ? Align(alignment: Alignment.centerLeft, child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(widget.str, style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w900, height: 1.1), textAlign: TextAlign.center,),
            )) : Align(alignment: Alignment.centerLeft, child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.str, style: TextStyle(fontSize: 16, color: Color(0xFFFAFF00), fontWeight: FontWeight.w900, height: 1.1), textAlign: TextAlign.center,),
                  SizedBox(height: 16,),
                  Container(
                    width: 120,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: !valuer ? Color(0xFF8F00FF) : Color(0xFF8D2781),
                    ),
                    alignment: Alignment.center,
                    child: !valuer ? Text('Ready', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.white),) :
                        Text(formatDuration(_timeDifference), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),)
                  )
                ],
              ),
            ))
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
