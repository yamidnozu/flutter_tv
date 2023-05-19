// No es compatible con aplicaciones web

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tv/app/domain/repositories/connectivity_repository.dart';
import 'package:tv/app/services/remote/internet_checker.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  final Connectivity _connectivity;
  final InternetChecker _internetChecker;

  ConnectivityRepositoryImpl(
    this._connectivity,
    this._internetChecker,
  ); // La solución para que sea testeable es esta, inyectar la dependencia en el constructor. En el main.dart se crea una instancia de Connectivity y se pasa como parametro

  @override
  Future<bool> get hasInternet async {
    // final result = Connectivity().checkConnectivity(); // De esta forma no es testeable, porque se crea una instancia de Connectivity y no se puede mockear
    // La mejor manera seria usando inyeccion de dependencias
    final result = _connectivity.checkConnectivity();
    if (result == ConnectivityResult.none) {
      return Future.value(false);
    }

    return _internetChecker.hasInternet();
  }
}
