import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';





class MusicPlayer extends StatefulWidget {
  const MusicPlayer({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  State<MusicPlayer> createState() => _MusicPlayer();
}

class _MusicPlayer extends State<MusicPlayer> {
  late Box storageBox;
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  bool isInitPlay = false;



  @override
  void initState() {
    super.initState();
    init();
  }


  Future<void> init() async {
    storageBox = await Hive.openBox('myBox');
    bool isMusicOn = storageBox.get('Music')!;



    if (isMusicOn) {
      play();
    }
  }



  Future setAudio() async {
    await audioPlayer.setReleaseMode(ReleaseMode.loop);
    await audioPlayer.setSourceAsset('audio/stormp_rap_adrenaline.mp3');
  }

  void play(){
    if(isInitPlay){
      audioPlayer.resume();
    } else {
      isInitPlay = true;
      setAudio().then((_) { audioPlayer.play(audioPlayer.source!); });
    }
  }

  void stop(){
    audioPlayer.pause();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return FutureBuilder(
        future:   getBox(),
        builder: (BuildContext context, AsyncSnapshot<Box> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            storageBox = snapshot.data!;
            return ValueListenableBuilder(
                valueListenable: storageBox.listenable(keys: ['Music']),
                builder: (context, Box box, _) {
                  bool isMusicOn = box.get('Music')!;
                  if(isMusicOn){
                    play();
                  } else {
                    stop();
                  }
                  print(isMusicOn);
                  return widget.child ?? const SizedBox();
                }
            );
          } else {
            return CircularProgressIndicator();
          }
        }
    );
  }
}
Future<Box> getBox() async {
  return await Hive.openBox('myBox');
}
