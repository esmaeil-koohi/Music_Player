import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayMusicPage extends StatefulWidget {
  const PlayMusicPage({Key? key}) : super(key: key);

  @override
  State<PlayMusicPage> createState() => _PlayMusicPageState();
}

class _PlayMusicPageState extends State<PlayMusicPage> {
  final AudioPlayer player = AudioPlayer();
  Timer? timer;
  bool stateMusic = false;
  int progressValue = 0;
  Duration? duration;
  @override
  void initState() {
    player.setAsset('assets/music.mp3');
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned.fill(
                child: Container(
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
                    ))),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
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
                      filter(),
                      const Icon(
                        CupertinoIcons.heart,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  child: Image.asset(
                    'assets/moli.jpg',
                    fit: BoxFit.cover,
                  ),
                )),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40),
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
                ),
                if(duration != null)
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Slider(
                    max: player.duration!.inMilliseconds.toDouble(),
                    value: progressValue.toDouble(),
                    inactiveColor: Colors.white12,
                    activeColor: Colors.white,
                    onChanged: (value) {
                      player.seek(Duration(milliseconds: value.toInt()));
                      setState(() {});
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 38.0, right: 38.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '5:45',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Text(
                        '12:40',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                musicButtonControl(),
                const SizedBox(height: 20,),
              ],
            ),
          ],
        ),
      ),
    );
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
              player.playing?
              timer!.cancel():
              startMusic();

              toggleStateMusic();
              setState(() {});
            },
            icon: Icon(
              player.playing
                  ? Icons.pause_circle_filled
                  : Icons.play_circle_filled,
              color: Colors.white,
              size: 50,
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

  filter() {
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

  startMusic() {
    const tick = Duration(milliseconds: 200);
    int duration = player.duration!.inMilliseconds - player.position.inMilliseconds;
    if (timer != null) {
      if (timer!.isActive) {
        timer!.cancel();
        timer = null;
      }
    }
    timer = Timer.periodic(tick, (timer) {
      setState(() {});
      duration--;
      progressValue = player.position.inMilliseconds;
      print('$duration');
      if (duration <= 0) {
        timer.cancel();
        progressValue = 0;
      }

    });
  }

  toggleStateMusic() {
    player.playing ? player.pause() : player.play();
  }
}
