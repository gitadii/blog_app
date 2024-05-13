part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

// Initial state
final class AuthInitial extends AuthState {}

// Loading
final class AuthLoading extends AuthState {}

// Success
final class AuthSucess extends AuthState {
  final UserEntity user;
  const AuthSucess(this.user);
}

// Failure
final class AuthFailure extends AuthState {
  final String message;
  const AuthFailure(this.message);
}

// Logout
final class AuthLoggedOut extends AuthState {}
