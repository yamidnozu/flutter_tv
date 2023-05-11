abstract class ConnectivityRepository {
  Future<bool> get hasInternet;
}


// final c = ConnectivityRepository(); // Error: The class 'ConnectivityRepository' is abstract and can't be instantiated.
