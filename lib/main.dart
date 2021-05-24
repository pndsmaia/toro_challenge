import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app.module.dart';
import 'app/app.widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp().then((firebaseApp) {
    runApp(ModularApp(module: AppModule(), child: AppWidget()));
  });
}
