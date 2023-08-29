import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/feature/feature.dart';

@Injectable(as: AuthRepository)
@prod
class NetworkAuthRepository implements AuthRepository {
  @override
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential response =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return response.user;
    } catch (_) {
      rethrow;
    }
  }
}
