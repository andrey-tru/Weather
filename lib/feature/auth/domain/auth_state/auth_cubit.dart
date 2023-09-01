import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/feature/feature.dart';

part 'auth_state.dart';

part 'auth_cubit.freezed.dart';
part 'auth_cubit.g.dart';

@Singleton()
class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit(this.authRepository, this.mainCubit) : super(AuthState.splash());

  final AuthRepository authRepository;
  final MainCubit mainCubit;

  Future<void> initial() async {
    final AuthState initialState =
        state == AuthState.splash() ? AuthState.notAuthorization() : state;
    emit(AuthState.splash());
    mainCubit.determinePosition();
    Future<void>.delayed(
      const Duration(seconds: 2),
      () => emit(initialState),
    );
  }

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

  void logOut() => emit(AuthState.notAuthorization());

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    final AuthState state = AuthState.fromJson(json);

    return state.whenOrNull(authorization: () => AuthState.authorization());
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state
            .whenOrNull(authorization: () => AuthState.authorization())
            ?.toJson() ??
        AuthState.notAuthorization().toJson();
  }
}
