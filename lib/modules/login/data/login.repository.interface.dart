import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_toro/libraries/common/models/user.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class ILoginRepository extends Disposable {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<bool> signIn({required String email, required String password});
  Future<bool> resendEmail();
  Future<void> signUp({
    required String email,
    required String password,
    required UserModel user,
  });
}
