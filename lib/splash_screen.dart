import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_project/components/no_network.dart';
import 'package:flutter_project/news_list_screen.dart';
import 'package:flutter_project/res/appcolors.dart';
import 'package:flutter_project/res/images.dart';
import 'package:flutter_project/utils/network_util.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // this fuction holds splash screen for 3 seconds and redirects to News list screen
  Future<void> launchNextScreen(BuildContext context) async {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NewsListScreen(),
        ),
      );
    });
  }

  @override
  void initState() {
    launchNextScreen(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    return connectionStatus == ConnectivityStatus.Offline
        ? const Scaffold(body: NoNetwork())
        : Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: Center(
              child: Image.asset(
                Images.splash,
                color: AppColors.black,
                fit: BoxFit.contain,
                width: 200,
                height: 200,
              ),
            ),
          );
  }
}
