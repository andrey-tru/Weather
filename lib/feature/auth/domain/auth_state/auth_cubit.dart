import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/feature/feature.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState.notAuthorization());

  final AuthRepository authRepository;

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthState.loading());

    try {
      await authRepository.signIn(email: email, password: password);

      emit(AuthState.authorization());
    } catch (error) {
      emit(AuthState.error(error.toString()));
      rethrow;
    }
  }
}
