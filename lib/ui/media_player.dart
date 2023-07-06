import '/all.dart';

class AudioPlayerScreen extends StatelessWidget {
  AudioPlayerScreen({Key? key}) : super(key: key);

  final AudioPlayerController audioPlayerController =
      Get.put(AudioPlayerController());

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCurrentlyPlaying(),
              Center(
                child: audioPlayerController.isPlaying.value
                    ? const AnimatedRotatingWidget(
                        duration: Duration(seconds: 100),
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: AssetImage(
                            'assets/img/cat.png',
                          ),
                        ),
                      )
                    : const CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage(
                          'assets/img/cat.png',
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              _buildSlider(),
              _buildLabel(),
              const SizedBox(height: 20),
              _buildPlayButton(),
              const Spacer(),
              _buildPickFileButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            audioPlayerController.currentSpeed.value -= 0.1;
            if (audioPlayerController.currentSpeed.value.isNegative) {
              audioPlayerController.currentSpeed.value = 2.0;
            }
            audioPlayerController.audioPlayer
                .setPlaybackRate(audioPlayerController.currentSpeed.value);
            audioPlayerController.isPlaying.value = true;
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        InkWell(
          onTap: () async {
            if (audioPlayerController.mediaFile == null) {
              BotToast.showText(
                text: "You haven't pick a file yet!".tr,
                duration: const Duration(seconds: 1),
              );
              return;
            }
            if (audioPlayerController.isPlaying.value) {
              await audioPlayerController.audioPlayer.pause();
            } else {
              await audioPlayerController.audioPlayer.resume();
            }
          },
          child: Card(
            elevation: 8,
            color: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: SizedBox(
              width: 60,
              height: 60,
              // decoration: BoxDecoration(
              //     color: Colors.deepPurple,
              //     borderRadius: BorderRadius.circular(8)),
              child: Icon(
                audioPlayerController.isPlaying.value
                    ? Icons.pause
                    : Icons.play_arrow,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            audioPlayerController.currentSpeed.value += 0.1;
            if (audioPlayerController.currentSpeed.value > 3) {
              audioPlayerController.currentSpeed.value = 1.0;
            }
            audioPlayerController.audioPlayer
                .setPlaybackRate(audioPlayerController.currentSpeed.value);
            audioPlayerController.isPlaying.value = true;
          },
          child: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }

  Widget _buildPickFileButton() {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: InkWell(
            onTap: () {
              audioPlayerController.setAudio();
            },
            child: Card(
              elevation: 8,
              color: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(8),
                //   color: Colors.deepPurple,
                // ),
                height: 50,
                child: Center(
                  child: Text(
                    'Choose MP3 file'.tr,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Flexible(
          flex: 1,
          child: InkWell(
            onTap: () => audioPlayerController.reset(),
            child: Card(
              elevation: 8,
              color: Colors.red[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: SizedBox(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(8),
                //   color: Colors.red[700],
                // ),
                height: 50,
                child: Center(
                  child: Text(
                    'Reset'.tr,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentlyPlaying() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Currently playing: '.tr,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(audioPlayerController.playingFile.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Speed: '.tr,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              SizedBox(
                width: 25,
                child: Center(
                  child: Text(
                    audioPlayerController.currentSpeed.toStringAsFixed(1),
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLabel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(audioPlayerController.pos.toString()),
          Text(audioPlayerController.dur.toString()),
        ],
      ),
    );
  }

  Widget _buildSlider() {
    return SliderTheme(
      data: const SliderThemeData(
          trackHeight: 5, thumbShape: RoundSliderThumbShape()),
      child: Slider(
        activeColor: Colors.deepPurple,
        inactiveColor: Colors.deepPurple[100],
        min: 0,
        max: audioPlayerController.duration.value,
        value: audioPlayerController.position.value,
        onChanged: (value) async {
          final position = Duration(seconds: value.toInt());
          await audioPlayerController.audioPlayer.seek(position);
          await audioPlayerController.audioPlayer.resume();
        },
      ),
    );
  }
}
