import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class ISessionRepository extends Disposable {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? get getUser;
  Future<void> signOut();
}
