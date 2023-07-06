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

  RxList<String> list = <String>[
    '1.0',
    '1.1',
    '1.2',
    '1.3',
    '1.4',
    '1.5',
    '1.6',
    '1.7',
    '1.8',
    '1.9',
    '2.0'
  ].obs;

  @override
  void onInit() {
    listener();
    super.onInit();
  }

  final audioPlayer = AudioPlayer();

  Future<void> setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.LOOP);

    final _temp = await FilePicker.platform.pickFiles();

    if (_temp != null){
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
    if (mediaFile != null) await audioPlayer.resume();
  }

  void reset() {
    mediaFile = null;
    playingFile.value = '';
    currentSpeed.value = 1.0;
    audioPlayer.stop();
    dur.value = '';
    pos.value = '';
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
