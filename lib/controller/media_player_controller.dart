import '/all.dart';

class AudioPlayerController extends GetxController {
  final RxDouble currentSpeed = 1.0.obs;
  final RxDouble duration = 0.0.obs;
  final RxString dur = ''.obs;
  final RxString pos = ''.obs;
  final RxDouble position = 0.0.obs;
  final RxBool isPlaying = false.obs;
  final RxString playingFile = ''.obs;

  FilePickerResult? mediaFile;

  @override
  void onInit() {
    listener();
    super.onInit();
  }

  final audioPlayer = AudioPlayer();

  Future<void> setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.LOOP);

    final _temp = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3'],
    );

    if (_temp != null) {
      mediaFile = _temp;
    }

    if (mediaFile != null) {
      final file = File(mediaFile!.files.single.path!);
      audioPlayer.setUrl(file.path, isLocal: true);
      playingFile.value = file.path.split(Platform.pathSeparator).last;
      audioPlayer.resume();
    }
  }

  Future<void> resume() async {
    if (mediaFile != null) {
      await audioPlayer.resume();
    }
  }

  void resetAll() async {
    mediaFile = null;
    await resetSpeed();
    audioPlayer.stop();
  }

  Future<void> resetSpeed() async {
    currentSpeed.value = 1.0;
    await audioPlayer.setPlaybackRate(currentSpeed.value);
  }

  void listener() {
    audioPlayer.onPlayerStateChanged.listen((event) {
      isPlaying.value = event == PlayerState.PLAYING;
    });

    audioPlayer.onDurationChanged.listen((event) {
      duration.value = event.inMilliseconds / 1000;
      dur.value = formatDuration(duration.value);
    });

    audioPlayer.onAudioPositionChanged.listen((event) {
      position.value = event.inMilliseconds / 1000;
      pos.value = formatDuration(position.value);
    });
  }
}
