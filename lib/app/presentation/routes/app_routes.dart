import 'package:flutter/material.dart';
import 'package:tv/app/presentation/modules/home/views/home.dart';
import 'package:tv/app/presentation/modules/offline/views/offline.dart';
import 'package:tv/app/presentation/modules/sign_in/views/sign_in.dart';
import 'package:tv/app/presentation/modules/splash/views/splash.dart';
import 'package:tv/app/presentation/routes/routes.dart';

Map<String, Widget Function(BuildContext context)> get appRoutes => {
      Routes.splash: (context) => const SplashView(),
      Routes.signIn: (context) => const SignInView(),
      Routes.home: (context) => const HomeView(),
      Routes.noInternet: (context) => const OfflineView(),
    };
