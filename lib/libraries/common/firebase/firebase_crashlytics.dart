import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FbCrashlytics extends Disposable {
  static FirebaseCrashlytics _firebaseCrashlytics =
      FirebaseCrashlytics.instance;

  static FirebaseAuth _auth = FirebaseAuth.instance;

  static void sendForcedCrash() async {
    _firebaseCrashlytics.crash();
  }

  static Future<void> sendNonFatalCrash(dynamic exception, StackTrace stack,
      {dynamic? context, String? message}) async {
    User? user = _auth.currentUser;
    try {
      if (Platform.isIOS || Platform.isAndroid) {
        if (user != null)
          await _firebaseCrashlytics.setUserIdentifier(user.uid);
        if (message != null && message.isNotEmpty) await _crashLog(message);

        await _firebaseCrashlytics.recordError(exception, stack,
            reason: context);
      }
    } catch (e) {
      print('ERROR DONT SENDED TO FIREBASE:\n$e');
    }
  }

  static Future<void> _crashLog(String message) async {
    try {
      await _firebaseCrashlytics.log(message);
    } catch (e) {
      print(
          'IT WAS NOT POSSIBLE TO GENERATE CUSTOMIZED LOG TO SEND THE ERROR TO FIREBASE:\n$e');
    }
  }

  @override
  void dispose() {}
}
