import 'dart:async';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayerController extends GetxController{
  final player = AudioPlayer();
  RxBool playState = false.obs;
  Rx<Duration> progressValue = Duration(seconds: 0).obs;
  Rx<Duration> bufferedValue = Duration(seconds: 0).obs;
  Timer? timer;


  @override
  onInit(){
    super.onInit();
    player.setAsset('assets/music.mp3');
  }


  toggleStateMusic() {
    player.playing ? player.pause() : player.play();
    playState.value = player.playing;

  }

  startProgress(){
    const tick = Duration(seconds: 1);
    int duration = player.duration!.inSeconds - player.position.inSeconds;
    if(timer != null){
      if(timer!.isActive){
        timer!.cancel();
        timer = null;
      }
    }

      timer = Timer.periodic(tick, (timer) {
        duration --;
        print('$duration');
        progressValue.value = player.position;
        bufferedValue.value = player.bufferedPosition;
        if(duration <= 0 ){
          timer.cancel();
          progressValue.value = const Duration(seconds: 0);
          bufferedValue.value = const Duration(seconds: 0);
        }
      });
  }


}