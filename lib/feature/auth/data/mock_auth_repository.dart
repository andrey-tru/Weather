import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/feature/feature.dart';

@Injectable(as: AuthRepository)
@test
class MockAuthRepository implements AuthRepository {
  @override
  Future<User?> signIn({required String email, required String password}) {
    return Future<User?>.delayed(const Duration(seconds: 2), () {
      return null;
    });
  }
}
