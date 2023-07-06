String formatDuration(double durationInSeconds) {
  int hours = durationInSeconds ~/ 3600;
  int minutes = (durationInSeconds % 3600) ~/ 60;
  int seconds = durationInSeconds.toInt() % 60;

  String formattedHours = hours.toString().padLeft(2, '0');
  String formattedMinutes = minutes.toString().padLeft(2, '0');
  String formattedSeconds = seconds.toString().padLeft(2, '0');

  return "$formattedHours:$formattedMinutes:$formattedSeconds";
}