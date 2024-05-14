part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

// Sign up
final class AuthSignUp extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const AuthSignUp({
    required this.email,
    required this.name,
    required this.password,
  });
}

// Log in
final class AuthLogIn extends AuthEvent {
  final String email;
  final String password;

  const AuthLogIn({
    required this.email,
    required this.password,
  });
}

// Is user logged in?
final class AuthIsUserLoggedIn extends AuthEvent {}
