// ignore_for_file: prefer_const_constructors

import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

abstract class AuthInfra {
  final LocalAuthentication localAuth = LocalAuthentication();

  static Future<bool> checkBiometric() async {
    final LocalAuthentication auth = LocalAuthentication();
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      print("error biome trics $e");
    }

    print("biometric is available: $canCheckBiometrics");

    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } catch (e) {
      print("error enumerate biometrics $e");
    }

    print("following biometrics are available");
    if (availableBiometrics.isNotEmpty) {
      availableBiometrics.forEach((ab) {
        print("\ttech: $ab");
      });
    } else {
      print("no biometrics are available");
    }

    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
          localizedReason: 'Touch your finger on the sensor to login',
          options: AuthenticationOptions(
            stickyAuth: false,
            useErrorDialogs: true,
          ),
          authMessages: <AuthMessages>[
            AndroidAuthMessages(
              signInTitle: 'Oops! Biometric authentication required!',
              cancelButton: 'No thanks',
            ),
          ]);
    } catch (e) {
      print("error using biometric auth: $e");
    }

    return authenticated;
  }
}
