import 'package:flutter/material.dart';
import 'package:flutter_project/l10n/app_localization.dart';
import 'package:flutter_project/localization_provider.dart';
import 'package:flutter_project/splash_screen.dart';
import 'package:flutter_project/themeProvider.dart';
import 'package:flutter_project/utils/network_util.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        StreamProvider<ConnectivityStatus>(
          create: (ctx) => NetworkUtil().connectionStatusController.stream,
          initialData: ConnectivityStatus.WiFi,
        ),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LocalizationProvider>(
      builder: (context, themeProvider, localizationProvider, child) {
        return MaterialApp(
            title: 'News Flash',
            theme:
                themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            locale: localizationProvider.locale,
            supportedLocales: const [
              Locale('en', ''),
              Locale('hi', ''),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: SplashScreen(),
            debugShowCheckedModeBanner: false);
      },
    );
  }
}
