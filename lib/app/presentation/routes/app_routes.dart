import 'package:flutter/material.dart';
import 'package:tv/app/presentation/modules/splash/views/splash.dart';
import 'package:tv/app/presentation/routes/routes.dart';

Map<String, Widget Function(BuildContext context)> get appRoutes => {
      Routes.splash: (context) => const SplashView(),
    };
