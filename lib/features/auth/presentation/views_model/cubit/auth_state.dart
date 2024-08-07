part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String errorMessage;

  AuthFailure(this.errorMessage);
}

class AuthPasswordResetSuccess extends AuthState {}

class AuthPasswordChangeSuccess extends AuthState {}

class AuthSignOutSuccess extends AuthState {}
