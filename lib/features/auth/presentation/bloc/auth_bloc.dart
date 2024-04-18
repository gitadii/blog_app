import 'package:blog_app/core/usecases/usecase_interf.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogIn _userLogin;
  final CurrentUser _currentUser;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogIn userLogIn,
    required CurrentUser currentUser,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogIn,
        _currentUser = currentUser,
        super(AuthInitial()) {
    // When there is an event of AuthSignUp then do this :
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogIn>(_onAuthLogIn);
    on<AuthIsUserLoggedIn>(_onAuthIsUserLoggedIn);
  }

// FUCNTIONS TO MAKE CODE CLEAN
  void _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
// Until the signUp is complete the app should be in Loading state
    emit(AuthLoading());

    final res = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(AuthSucess(r)),
    );
  }

  void _onAuthLogIn(
    AuthLogIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final res = await _userLogin(UserLoginParams(
      email: event.email,
      password: event.password,
    ));

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(AuthSucess(r)),
    );
  }

  void _onAuthIsUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());

    res.fold((l) => emit(AuthFailure(l.message)), (r) {
      print(r.id);
      emit(AuthSucess(r));
    });
  }
}
