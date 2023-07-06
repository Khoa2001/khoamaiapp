import '/all.dart';

class AudioPlayerScreen extends StatelessWidget {
  AudioPlayerScreen({Key? key}) : super(key: key);

  final AudioPlayerController audioPlayerController =
      Get.put(AudioPlayerController());

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMenu(),
                _buildSlider(),
                const Spacer(),
                _buildLabel(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenu() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            audioPlayerController.setAudio();
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Center(
              child: Text(
                'Choose MP3 file'.tr,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () {
            audioPlayerController.resetAll();
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.red,
            ),
            child: Center(
              child: Text(
                'X'.tr,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () async {
            if (audioPlayerController.mediaFile == null) {
              return;
            }
            if (audioPlayerController.isPlaying.value) {
              await audioPlayerController.audioPlayer.pause();
            } else {
              await audioPlayerController.audioPlayer.resume();
            }
          },
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
            ),
            child: Center(
              child: Icon(
                audioPlayerController.isPlaying.value
                    ? Icons.pause
                    : Icons.play_arrow,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: () {
            audioPlayerController.currentSpeed.value += 0.1;
            if (audioPlayerController.currentSpeed.value >= 3) {
              audioPlayerController.currentSpeed.value = 1.0;
            }
            if (audioPlayerController.mediaFile == null) {
              return;
            }
            audioPlayerController.audioPlayer
                .setPlaybackRate(audioPlayerController.currentSpeed.value);
            if (audioPlayerController.mediaFile != null) {
              audioPlayerController.isPlaying.value = true;
            }
          },
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: Colors.white),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'x${audioPlayerController.currentSpeed.value.toStringAsFixed(1)}',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          audioPlayerController.pos.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        Text(
          audioPlayerController.dur.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildSlider() {
    return SliderTheme(
      data: const SliderThemeData(
        trackHeight: 5,
        thumbShape: RoundSliderThumbShape(),
      ),
      child: Slider(
        activeColor: Colors.white,
        inactiveColor: Colors.grey[500],
        min: 0,
        max: audioPlayerController.duration.value,
        value: audioPlayerController.position.value,
        onChanged: (value) async {
          if (audioPlayerController.mediaFile == null) {
            return;
          }
          final position = Duration(seconds: value.toInt());
          await audioPlayerController.audioPlayer.seek(position);
          await audioPlayerController.audioPlayer.resume();
        },
      ),
    );
  }
}
