import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FbAnalytics extends Disposable {
  static FirebaseAnalytics _analytics = FirebaseAnalytics();
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<bool> sendEvent({
    required String event,
    Map<String, dynamic>? parameters,
  }) async {
    if (parameters == null) parameters = {};
    try {
      if (!Platform.isMacOS && !Platform.isLinux && !Platform.isWindows) {
        if (event.length > 40) {
          event = event.substring(0, 40);
        }
        await _setUserProperties();
        await _analytics.logEvent(name: event, parameters: parameters);
        return true;
      }
      return false;
    } catch (e) {
      print('ERROR AO REGISTRAR EVENTO NO FIREBASE ANALYTICS:\n$e');

      return false;
    }
  }

  static Future<bool> setCurrentScreen({
    required String screenName,
    required String screenClassOverride,
  }) async {
    try {
      if (!Platform.isMacOS && !Platform.isLinux && !Platform.isWindows) {
        await _analytics.setCurrentScreen(
            screenName: screenName, screenClassOverride: screenClassOverride);

        return true;
      }
      return false;
    } catch (e) {
      print('ERROR AO REGISTRAR EVENTO NO FIREBASE ANALYTICS:\n$e');

      return false;
    }
  }

  static Future<bool> _setUserProperties() async {
    User? user = _auth.currentUser;
    try {
      DateTime now = DateTime.now();

      if (user != null) {
        await _analytics.setUserProperty(
          name: 'accessDate',
          value:
              '${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}',
        );
        await _analytics.setUserProperty(
          name: 'name',
          value: user.displayName ?? '',
        );
        await _analytics.setUserProperty(
          name: 'phoneNumber',
          value: user.phoneNumber,
        );
        await _analytics.setUserProperty(name: 'email', value: user.email);
      }

      return true;
    } catch (e) {
      print('ERROR AO SETAR PROPRIEDADE DO USUÁRIO NO FIREBASE ANALYTICS:\n$e');

      return false;
    }
  }

  static Future<bool> setUserId() async {
    User? user = _auth.currentUser;
    try {
      if (!Platform.isMacOS && !Platform.isLinux && !Platform.isWindows) {
        if (user != null) {
          _analytics.setUserId(user.uid);
          return true;
        }
      }
      return false;
    } catch (e) {
      print('ERROR AO SETAR ID DO USUÁRIO NO FIREBASE ANALYTICS:\n$e');

      return false;
    }
  }

  @override
  void dispose() {}
}
