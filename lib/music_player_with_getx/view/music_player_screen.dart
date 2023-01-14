import 'dart:ui';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/music_player_with_getx/controller/music_controller.dart';

class MusicPlayerScreen extends StatelessWidget {
  MusicPlayerScreen({Key? key}) : super(key: key);

  final MusicPlayerController controller = Get.put(MusicPlayerController());
  final double distanceFromLeftAndRight = 40.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned.fill(child: filter()),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: profile(),
                ),
                poster(),
                const SizedBox(height: 10,),
                about(),
                Padding(
                  padding: EdgeInsets.only(left: distanceFromLeftAndRight , right: distanceFromLeftAndRight),
                  child: progress(),
                ),
                musicButtonControl(),
                const SizedBox(height: 22,),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget progress() {
    return Obx(
      () => ProgressBar(
        timeLabelTextStyle: TextStyle(color: Colors.white),
        thumbColor: Colors.white,
        baseBarColor: Colors.white24,
        bufferedBarColor: Colors.black26,
        progressBarColor: Colors.white,
        buffered: controller.bufferedValue.value,
        progress: controller.progressValue.value,
        total: controller.player.duration ?? const Duration(seconds: 0),
        onSeek: (position) async {
          controller.player.seek(position);
           if(controller.player.playing){
            controller.startProgress();
           }
        },
      ),
    );
  }

  Widget about() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: distanceFromLeftAndRight, bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Powerful fairy living in the Moors',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              'Maleficent',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget profile() {
    return Row(
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1.0, color: Colors.grey),
              image: const DecorationImage(
                image: AssetImage(
                  'assets/mali.jpg',
                ),
                fit: BoxFit.cover,
              )),
        ),
        const SizedBox(
          width: 16,
        ),
        musicName(),
        const Icon(
          CupertinoIcons.heart,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget filter() {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage(
                  'assets/moli.jpg',
                ),
                fit: BoxFit.cover)),
        child: BackdropFilter(
          child: Container(
            color: Colors.black12,
          ),
          filter: ImageFilter.blur(
            sigmaX: 30,
            sigmaY: 30,
          ),
        ));
  }

  Widget poster() {
    return Expanded(
        child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(24)),
      child: Image.asset(
        'assets/moli.jpg',
        fit: BoxFit.cover,
      ),
    ));
  }

  Widget musicButtonControl() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.skip_previous,
              color: Colors.white,
              size: 50,
            )),
        IconButton(
            onPressed: () {
              controller.player.playing
                  ? controller.timer!.cancel()
                  : controller.startProgress();
              controller.toggleStateMusic();
            },
            icon: Obx(
              () => Icon(
                controller.playState.value
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_filled,
                color: Colors.white,
                size: 50,
              ),
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.skip_next,
              color: Colors.white,
              size: 50,
            )),
      ],
    );
  }

  Widget musicName() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Angelina Jolie',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            '@angelina_jolie',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
