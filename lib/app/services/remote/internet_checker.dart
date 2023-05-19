import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class InternetChecker {
  Future<bool> hasInternet() async {
    // Tenemos que garantizar que tenemos internet.
    try {
      if (kIsWeb) {
        final response = await get(Uri.parse('google.com')); // Sino 8.8.8.8 dns de google
        return response.statusCode == 200;
      } else {
        final list = await InternetAddress.lookup('google.com');
        return list.isNotEmpty && list.first.rawAddress.isNotEmpty;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
