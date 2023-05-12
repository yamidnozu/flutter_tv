import 'package:flutter/material.dart';
import 'package:tv/app/domain/repositories/connectivity_repository.dart';
import 'package:tv/app/presentation/routes/routes.dart';
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
    final injector = Injector.of(context);
    final ConnectivityRepository connectivityRepository =
        injector.connectivityRepository;

    final bool hasInternet = await connectivityRepository.hasInternet;

    if (hasInternet) {
      // Navigator.pushReplacementNamed(context, Routes.home);
      print("✅ Hay internet");

      final authenticationRepository = injector.authenticationRepository;
      final isSignedIn = await authenticationRepository.isSignedIn;
      if (isSignedIn) {
        final user = await authenticationRepository.getUserData();
        if (mounted) {
          // Para solucionar un problemita para saber si un widget renderizo o no, eso es cuando se usa context luego de un await

          if (user != null) {
            _goTo(Routes.home);
          } else {
            _goTo(Routes.signIn);
          }
        }
      } else if (mounted) {
        // Para solucionar un problemita para saber si un widget renderizo o no, eso es cuando se usa context luego de un await
        _goTo(Routes.signIn);
      } else {}
    } else {
      // Navigator.pushReplacementNamed(context, Routes.noInternet);
      print("❌ No hay internet");
      _goTo(Routes.noInternet);
    }
  }

  _goTo(String routeName) async {
    Navigator.pushReplacementNamed(context, routeName);
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
