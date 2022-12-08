import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricsVerifier {
  late LocalAuthentication auth;

  BiometricsVerifier() {
    auth = LocalAuthentication();
  }

  Future<void> _ableToAuthenticate() async {
    bool supported = await auth.canCheckBiometrics;
    bool entryExists = await auth.isDeviceSupported();
    if (!supported) throw "دستگاه شما از قابلیت اثرانگشت پشتیبانی نمی کند";
    if (!entryExists) throw "اثرانگشت وارد نشد";
  }

  Future<void> verifyBiometrics(String? prompt) async {
    await _ableToAuthenticate();
    late bool didAuthenticate;
    try {
      didAuthenticate = await auth.authenticate(
        localizedReason: prompt ?? 'Please authenticate with biometrics',
        options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
            useErrorDialogs: true,
            sensitiveTransaction: true),
      );
    } on PlatformException {
      throw "Platform Exception : Biometrics Failed !";
    }
    if (!didAuthenticate) throw "خطا در تایید اثر انگشت";
  }
}
