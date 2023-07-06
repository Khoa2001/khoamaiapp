import 'all.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('vi', 'VN'),
      translationsKeys: AppTranslation.translations,
      builder: (context, child) {
        return resolution(context, child);
      },
      debugShowCheckedModeBanner: false,
      title: 'Audio Player App',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primarySwatch: Colors.blue,
      ),
      home: AudioPlayerScreen(),
    );
  }

  Widget resolution(BuildContext context, Widget? child) {
    final mediaQueryData = MediaQuery.of(context);
    final width = mediaQueryData.size.width;
    final height = mediaQueryData.size.height;

    const desiredWidth = 500.0;
    const desiredHeight = 170.0;

    final scaleFactorX = width / desiredWidth;
    final scaleFactorY = height / desiredHeight;
    final scaleFactor =
        scaleFactorX < scaleFactorY ? scaleFactorX : scaleFactorY;

    return MediaQuery(
      data: mediaQueryData.copyWith(
        size: mediaQueryData.size,
        textScaleFactor: mediaQueryData.textScaleFactor,
        devicePixelRatio: mediaQueryData.devicePixelRatio * scaleFactor,
      ),
      child: child!,
    );
  }
}
