import 'package:flutter/material.dart';
import 'package:tv/app/data/repositories_implementation/authentication_repository_impl.dart';
import 'package:tv/app/data/repositories_implementation/connectivity_repositories_impl.dart';
import 'package:tv/app/domain/repositories/authentication_repository.dart';
import 'package:tv/app/domain/repositories/connectivity_repository.dart';
import 'package:tv/app/my_app.dart';

void main() {
  runApp(
    Injector(
      child: const MyApp(),
      authenticationRepository: AuthenticationRepositoryImpl(),
      connectivityRepository: ConnectivityRepositoryImpl(),
    ),
  );
}

class Injector extends InheritedWidget {
  const Injector({
    super.key,
    required super.child,
    required this.connectivityRepository,
    required this.authenticationRepository,
  });

  final ConnectivityRepository connectivityRepository;
  final AuthenticationRepository authenticationRepository;

  // Aqui solo se van a declarar los repositorios y estos no van a cambiar durante toda la ejecucipon de la app
  @override
  bool updateShouldNotify(_) {
    return false; // Por eso este false
  }

  static Injector of(BuildContext context) {
    final injector = context.dependOnInheritedWidgetOfExactType<Injector>();
    assert(injector != null, "No se encontro el injector");
    return injector!;
  }
}
