import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_toro/libraries/common/models/user.model.dart';
import 'package:desafio_toro/modules/login/data/login.repository.interface.dart';

class LoginRepository extends ILoginRepository {
  @override
  Future<bool> signIn({required String email, required String password}) async {
    bool result = false;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      result = auth.currentUser!.emailVerified
          ? auth.currentUser!.emailVerified
          : throw Exception('email-not-verified');
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> signUp({
    required String email,
    required String password,
    required UserModel user,
  }) async {
    bool result = false;
    CollectionReference userCollection = firestore.collection('users');
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (auth.currentUser != null) {
        user.id = auth.currentUser!.uid;
        QuerySnapshot verifyCpfSnapshot =
            await userCollection.where('cpf', isEqualTo: user.cpf).get();
        if (verifyCpfSnapshot.docs.length == 0) {
          await userCollection.doc(auth.currentUser!.uid).set(user.toMap());
          await auth.currentUser!.sendEmailVerification();
          await auth.signOut();
          result = true;
        } else {
          await auth.currentUser!.delete();
          result = false;
          throw Exception('cpf-in-use');
        }
      }
    } catch (e) {
      if (auth.currentUser != null) await auth.currentUser!.delete();
      rethrow;
    }
    return result;
  }

  @override
  Future<bool> resendEmail() async {
    try {
      if (auth.currentUser != null) {
        await auth.currentUser!.sendEmailVerification();
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {}
}
