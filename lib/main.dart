import 'all.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('vi', 'VN'),
      translationsKeys: AppTranslation.translations,
      builder: BotToastInit(),
      debugShowCheckedModeBanner: false,
      title: 'Audio Player App',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primarySwatch: Colors.blue,
      ),
      home: AudioPlayerScreen(),
    );
  }
}

