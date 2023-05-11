import 'package:flutter/material.dart';
import 'package:tv/app/domain/repositories/connectivity_repository.dart';
import 'package:tv/main.dart';

// Convertir de StatelessWidget a StatefulWidget
// Init state y hacer comprobacion si hay internet
// Notar que realmente no se esta haciendo arquitectura limpia, ConnectivityRepositoryImpl pertenece
// a la capa de datos, y SplashView pertenece a la capa de presentación,
// de la capa de presentacion no deberia depender de la capa de datos

// Parte 4:
//  De la clase Injector  recuperar connectivityRepository
// usar WidgetsBinding.instance.addPostFrameCallback((_) { ... }) para esperar a que se construya el widget

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  Future<void> _init() async {
    final ConnectivityRepository connectivityRepository =
        Injector.of(context).connectivityRepository;

    final bool hasInternet = await connectivityRepository.hasInternet;

    if (hasInternet) {
      // Navigator.pushReplacementNamed(context, Routes.home);
      print("✅ Hay internet");
    } else {
      // Navigator.pushReplacementNamed(context, Routes.noInternet);
      print("❌ No hay internet");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SizedBox(
        width: 80,
        height: 80,
        child: CircularProgressIndicator(),
      ),
    ));
  }
}
