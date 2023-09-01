part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  factory AuthState.splash() = _AuthStateSplash;

  factory AuthState.notAuthorization() = _AuthStateNotAuthorization;

  factory AuthState.authorization() = _AuthStateAuthorization;

  factory AuthState.loading() = _AuthStateloading;

  factory AuthState.error(String error) = _AuthStateError;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}
