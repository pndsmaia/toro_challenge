import 'package:desafio_toro/libraries/session/data/session.respository.interface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SessionRepository extends ISessionRepository {
  @override
  Future<bool> signOut() async {
    try {
      if (auth.currentUser != null) {
        await auth.signOut();
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  @override
  User? get getUser => auth.currentUser;

  @override
  void dispose() {}
}
